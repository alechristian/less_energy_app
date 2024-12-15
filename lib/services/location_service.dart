import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:less_energy/utils/messages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Position? _lastKnownPosition;

  LocationService() {
    initializeNotifications();
    startLocationUpdates();
  }

  void initializeNotifications() {
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void startLocationUpdates() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) {
      if (position != null) {
        _checkProximity(position);
      }
    });
  }

  void _checkProximity(Position position) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final homeLocation = Position(
      latitude: double.parse(prefs.getString('homeLat') ?? '-23.550520'),
      longitude: double.parse(prefs.getString('homeLng') ?? '-46.633308'),
      timestamp: DateTime.now(),
      accuracy: 1.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 1.0,
      altitudeAccuracy: 1.0,
      headingAccuracy: 1.0,
    );

    final workLocation = Position(
      latitude: double.parse(prefs.getString('workLat') ?? '-16.647747'),
      longitude: double.parse(prefs.getString('workLng') ?? '-49.259431'),
      timestamp: DateTime.now(),
      accuracy: 1.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 1.0,
      altitudeAccuracy: 1.0,
      headingAccuracy: 1.0,
    );

    final universityLocation = Position(
      latitude: double.parse(prefs.getString('universityLat') ?? '-23.561414'),
      longitude: double.parse(prefs.getString('universityLng') ?? '-46.655881'),
      timestamp: DateTime.now(),
      accuracy: 1.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 1.0,
      altitudeAccuracy: 1.0,
      headingAccuracy: 1.0,
    );

    if (_isNearLocation(position, homeLocation)) {
      _sendNotificationForLocation('house', 'arriving');
    } else if (_isNearLocation(position, universityLocation)) {
      _sendNotificationForLocation('university', 'arriving');
    } else if (_isNearLocation(position, workLocation)) {
      _sendNotificationForLocation('work', 'arriving');
    }
  }

  bool _isNearLocation(Position currentPosition, Position targetPosition,
      {double threshold = 100.0}) {
    double distance = Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      targetPosition.latitude,
      targetPosition.longitude,
    );
    return distance <= threshold;
  }

  void _sendNotificationForLocation(String local, String event) {
    final filteredMessages = messages
        .where((message) => message.local == local && message.event == event)
        .toList();
    for (var message in filteredMessages) {
      _showNotificationWithDelay(message.text, message.text);
    }
  }

  Future<void> _showNotificationWithDelay(String title, String body) async {
    await Future.delayed(Duration(seconds: 5));
    _showNotification(title, body);
  }

  Future<void> _showNotification(String title, String body) async {
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails();
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: 'item x');
  }
}
