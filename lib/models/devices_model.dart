class Device {
  final String id;
  final String name;
  final String type;
  bool isOn;

  Device({
    required this.id,
    required this.name,
    required this.type,
    this.isOn = false,
  });

  void togglePower() {
    isOn = !isOn;
  }
}

class DevicesModel {
  List<Device> devices = [];

  void addDevice(Device device) {
    devices.add(device);
  }

  void removeDevice(String id) {
    devices.removeWhere((device) => device.id == id);
  }

  Device? getDeviceById(String id) {
    return devices.firstWhere((device) => device.id == id);
  }

  List<Device> getDevicesByType(String type) {
    return devices.where((device) => device.type == type).toList();
  }

  void toggleDevicePower(String id) {
    Device? device = getDeviceById(id);
    if (device != null) {
      device.togglePower();
    }
  }
}
