import 'package:flutter/material.dart';
import 'package:my_visitor_admin/generated/l10n.dart';
import 'package:my_visitor_admin/services/cities/cities.dart';
import 'package:my_visitor_admin/widgets/custom_text_field.dart';

class AddNewCityScreen extends StatefulWidget {
  const AddNewCityScreen({super.key});

  @override
  State<AddNewCityScreen> createState() => _AddNewCityScreenState();
}

class _AddNewCityScreenState extends State<AddNewCityScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController cityNameController = TextEditingController();
  final TextEditingController cityDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).add_a_new_city)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            Image.asset("images/map.png", height: 200, width: 200),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: S.of(context).enter_city_name,
              prefixIcon: Icons.location_city,
              keyboardType: TextInputType.text,
              controller: cityNameController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return S.of(context).please_enter_city_name;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: S.of(context).enter_city_description,
              prefixIcon: Icons.description,
              keyboardType: TextInputType.multiline,
              controller: cityDescriptionController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return S.of(context).please_enter_city_description;
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // Handle form submission
                  await Cities.addCity(
                    name: cityNameController.text,
                    description: cityDescriptionController.text,
                  );
                  Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        S.of(context).city_added_successfully,
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: Text(
                S.of(context).send,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
