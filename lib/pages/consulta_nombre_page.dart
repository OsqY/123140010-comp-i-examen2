import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/country_model.dart';
import '../constants/api.dart';

class ConsultaNombreScreen extends StatefulWidget {
  @override
  _ConsultaNombreScreenState createState() => _ConsultaNombreScreenState();
}

class _ConsultaNombreScreenState extends State<ConsultaNombreScreen> {
  final TextEditingController _controller = TextEditingController();
  Country? _country;
  bool error = false;

  Future<void> _fetchCountryByName(String name) async {
    final response = await http.get(Uri.parse('$nameEndpoint$name'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _country = Country.fromJson(data[0]);
        error = false;
      });
    } else {
      setState(() {
        _country = null;
        error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consulta por Nombre')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Nombre del País',
                border: OutlineInputBorder(),
              ),

            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _fetchCountryByName(_controller.text);
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Consultar'),
            ),
            const SizedBox(height: 20),
            if (_country != null) ...[
              Text('Nombre Común: ${_country!.commonName}',
                  style: Theme.of(context).textTheme.bodyLarge),
              Text('Nombre Oficial: ${_country!.officialName}',
                  style: Theme.of(context).textTheme.bodyLarge),
              Text('TLD: ${_country!.tld.join(", ")}',
                  style: Theme.of(context).textTheme.bodyLarge),
              Text('CCA2: ${_country!.cca2}',
                  style: Theme.of(context).textTheme.bodyLarge),
              Text('CCN3: ${_country!.ccn3}',
                  style: Theme.of(context).textTheme.bodyLarge),
            ],
            if (error)
              const Text('Error al cargar la información del país',
                  style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
