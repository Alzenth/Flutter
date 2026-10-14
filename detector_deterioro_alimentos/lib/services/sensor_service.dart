import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SensorData {
  final double gasPpm;
  final double temperatura;
  final double humedad;
  final String estado;
  final String alertaMensaje;

  SensorData({
    required this.gasPpm,
    required this.temperatura,
    required this.humedad,
    required this.estado,
    required this.alertaMensaje,
  });

  factory SensorData.fromMock() {
    return SensorData(
      gasPpm: 650.0,
      temperatura: 25.1,
      humedad: 74.0,
      estado: 'CRÍTICO',
      alertaMensaje: 'ALERTA: Carne en descomposición',
    );
  }

  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      gasPpm: (json['gas'] as num).toDouble(),
      temperatura: (json['temp'] as num).toDouble(),
      humedad: (json['hum'] as num).toDouble(),
      estado: json['estado'] ?? 'NORMAL',
      alertaMensaje: json['alerta'] ?? 'Estado estable',
    );
  }
}

class AppState extends ChangeNotifier {
  bool _useStaticData = true;
  String _esp32Ip = '192.168.1.50'; // IP por defecto del ESP32
  SensorData _currentData = SensorData.fromMock();
  bool _isConnected = true;
  Timer? _timer;

  bool get useStaticData => _useStaticData;
  SensorData get currentData => _currentData;
  bool get isConnected => _isConnected;
  String get esp32Ip => _esp32Ip;

  AppState() {
    _startPolling();
  }

  void setUseStaticData(bool value) {
    _useStaticData = value;
    if (_useStaticData) {
      _currentData = SensorData.fromMock();
      _isConnected = true;
    } else {
      // Limpia inmediatamente la pantalla de datos estáticos
      _currentData = SensorData(
        gasPpm: 0.0,
        temperatura: 0.0,
        humedad: 0.0,
        estado: 'CONECTANDO...',
        alertaMensaje: 'Buscando ESP32 en http://$_esp32Ip/datos',
      );
      _isConnected = false;
      _fetchEsp32Data();
    }
    notifyListeners();
  }

  void setEsp32Ip(String ip) {
    _esp32Ip = ip;
    if (!_useStaticData) {
      _fetchEsp32Data();
    }
    notifyListeners();
  }

  void _startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_useStaticData) {
        _fetchEsp32Data();
      }
    });
  }

  Future<void> _fetchEsp32Data() async {
    if (_useStaticData) return;

    try {
      final response = await http
          .get(Uri.parse('http://$_esp32Ip/datos'))
          .timeout(const Duration(seconds: 2));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        _currentData = SensorData.fromJson(data);
        _isConnected = true;
      } else {
        _setDisconnectedState('Respuesta inválida del servidor (${response.statusCode})');
      }
    } catch (_) {
      _setDisconnectedState('Sin conexión con ESP32 en IP: $_esp32Ip');
    }
    notifyListeners();
  }

  void _setDisconnectedState(String mensaje) {
    _isConnected = false;
    _currentData = SensorData(
      gasPpm: 0.0,
      temperatura: 0.0,
      humedad: 0.0,
      estado: 'DESCONECTADO',
      alertaMensaje: mensaje,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}