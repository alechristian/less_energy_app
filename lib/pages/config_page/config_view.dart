import 'package:flutter/material.dart';
import 'package:less_energy/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

class ConfigView extends StatefulWidget {
  @override
  _ConfigViewState createState() => _ConfigViewState();
}

class _ConfigViewState extends State<ConfigView> {
  final TextEditingController _homeLatController = TextEditingController();
  final TextEditingController _homeLngController = TextEditingController();
  final TextEditingController _workLatController = TextEditingController();
  final TextEditingController _workLngController = TextEditingController();
  final TextEditingController _universityLatController =
      TextEditingController();
  final TextEditingController _universityLngController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadHomeData();
    _loadWorkData();
    _loadUniversityData();
  }

  Future<void> _loadHomeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _homeLatController.text = prefs.getString('homeLat') ?? '';
      _homeLngController.text = prefs.getString('homeLng') ?? '';
    });
  }

  Future<void> _loadWorkData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _workLatController.text = prefs.getString('workLat') ?? '';
      _workLngController.text = prefs.getString('workLng') ?? '';
    });
  }

  Future<void> _loadUniversityData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _universityLatController.text = prefs.getString('universityLat') ?? '';
      _universityLngController.text = prefs.getString('universityLng') ?? '';
    });
  }

  Future<void> _saveHomeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('homeLat', _homeLatController.text);
    await prefs.setString('homeLng', _homeLngController.text);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dados da casa salvos com sucesso!')));
  }

  Future<void> _saveWorkData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('workLat', _workLatController.text);
    await prefs.setString('workLng', _workLngController.text);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dados do trabalho salvos com sucesso!')));
  }

  Future<void> _saveUniversityData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('universityLat', _universityLatController.text);
    await prefs.setString('universityLng', _universityLngController.text);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Dados da universidade salvos com sucesso!')));
  }

  Future<void> _getCurrentLocation(TextEditingController latController,
      TextEditingController lngController) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latController.text = position.latitude.toString();
      lngController.text = position.longitude.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryYellow,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField('Latitude Casa', _homeLatController),
            _buildTextField('Longitude Casa', _homeLngController),
            ElevatedButton(
              onPressed: _saveHomeData,
              child: const Text('Salvar Casa'),
            ),
            ElevatedButton(
              onPressed: () =>
                  _getCurrentLocation(_homeLatController, _homeLngController),
              child: const Text('Usar Localização Atual para Casa'),
            ),
            const SizedBox(height: 20),
            _buildTextField('Latitude Trabalho', _workLatController),
            _buildTextField('Longitude Trabalho', _workLngController),
            ElevatedButton(
              onPressed: _saveWorkData,
              child: const Text('Salvar Trabalho'),
            ),
            ElevatedButton(
              onPressed: () =>
                  _getCurrentLocation(_workLatController, _workLngController),
              child: const Text('Usar Localização Atual para Trabalho'),
            ),
            const SizedBox(height: 20),
            _buildTextField('Latitude Universidade', _universityLatController),
            _buildTextField('Longitude Universidade', _universityLngController),
            ElevatedButton(
              onPressed: _saveUniversityData,
              child: const Text('Salvar Universidade'),
            ),
            ElevatedButton(
              onPressed: () => _getCurrentLocation(
                  _universityLatController, _universityLngController),
              child: const Text('Usar Localização Atual para Universidade'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
