import 'package:flutter/material.dart';
import 'package:my_visitor_admin/generated/l10n.dart';
import 'package:my_visitor_admin/model/cities/activities/activities_model.dart';
import 'package:my_visitor_admin/services/cities/activities/activities.dart';
import 'package:my_visitor_admin/widgets/custom_text_field.dart';

class AddActivityScreen extends StatefulWidget {
  final String cityName;
  const AddActivityScreen({super.key, required this.cityName});

  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  List<TextEditingController> imageControllers = [TextEditingController()];

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    for (var controller in imageControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addImageField() {
    setState(() {
      imageControllers.add(TextEditingController());
    });
  }

  void _removeImageField(int index) {
    setState(() {
      imageControllers[index].dispose();
      imageControllers.removeAt(index);
    });
  }

  void _submitForm() async {
    if (formKey.currentState!.validate()) {
      final title = titleController.text.trim();
      final description = descriptionController.text.trim();
      final latitude = latitudeController.text.trim();
      final longitude = longitudeController.text.trim();
      final images =
          imageControllers.map((controller) => controller.text.trim()).toList();
      await Activities.addActivity(
        activity: ActivitiesModel(
          description: description,
          images: images,
          location: Location(
            latitude: double.parse(latitude),
            longitude: double.parse(longitude),
          ),
          title: title,
        ),
        city: widget.cityName,
      );
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            S.of(context).activity_added_successfully,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).add_new_activity),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Image.asset('images/activity.png', height: 200),
              const SizedBox(height: 16),
              CustomTextField(
                controller: titleController,
                hintText: S.of(context).title,
                prefixIcon: Icons.text_fields,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? S.of(context).field_required
                            : null,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: descriptionController,
                hintText: S.of(context).description,
                keyboardType: TextInputType.multiline,
                prefixIcon: Icons.notes,
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? S.of(context).field_required
                            : null,
              ),
              const SizedBox(height: 16),
              Text(
                S.of(context).image_url,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 8),
              ...List.generate(imageControllers.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: imageControllers[index],
                          hintText: S.of(context).add_image_url,
                          prefixIcon: Icons.photo,
                          validator:
                              (value) =>
                                  value == null || value.isEmpty
                                      ? S.of(context).field_required
                                      : null,
                          keyboardType: TextInputType.multiline,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (imageControllers.length > 1)
                        IconButton(
                          icon: const Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                          ),
                          onPressed: () => _removeImageField(index),
                        ),
                    ],
                  ),
                );
              }),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: _addImageField,
                  icon: const Icon(Icons.add, color: Colors.deepOrange),
                  label: Text(
                    S.of(context).add_image_url,
                    style: const TextStyle(color: Colors.deepOrange),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: latitudeController,
                      hintText: S.of(context).latitude,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      prefixIcon: Icons.my_location,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).field_required;
                        }
                        final lat = double.tryParse(value);
                        if (lat == null || lat < -90 || lat > 90) {
                          return S.of(context).invalid_latitude;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      controller: longitudeController,
                      hintText: S.of(context).longitude,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      prefixIcon: Icons.explore,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).field_required;
                        }
                        final lng = double.tryParse(value);
                        if (lng == null || lng < -180 || lng > 180) {
                          return S.of(context).invalid_longitude;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                ),
                onPressed: _submitForm,
                child: Text(
                  S.of(context).send,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
