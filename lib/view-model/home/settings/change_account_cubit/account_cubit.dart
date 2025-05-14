import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());
  static final ImagePicker _picker = ImagePicker();
  static final SupabaseClient supabase = Supabase.instance.client;
  static XFile? _localImage;
  static XFile? get loclImage => _localImage;
  static String? _imageLink;
  static String? get imageLink => _imageLink;

   Future<void> changeAccountInfo({
    required String name,
    required String email,
    required String phoneNumber,
    String imageUrl = "assets/images/defualt_profile.png",
  }) async {
    await uploadImage();
    if (_imageLink != null) {
      imageUrl = _imageLink!;
    }
    await FirebaseFirestore.instance.collection("users").doc(email).set({
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "profileImageUrl": imageUrl,
    });
    emit(AccountUpadted(
      localImage: _localImage,
      imageLink: _imageLink,
    ));
  }

   Future<XFile?> selectImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    _localImage = image;
    emit(AccountUpadted(
      localImage: _localImage,
      imageLink: _imageLink,
    ));
    return _localImage;
  }

   Future<void> uploadImage() async {
    try {
      final XFile? image = _localImage;
      if (image == null) return;

      File file = File(image.path);
      String fileName =
          "profile-images/${DateTime.now().millisecondsSinceEpoch}.jpg";

      await supabase.storage.from('profile-images').upload(fileName, file);

      final String publicUrl = supabase.storage
          .from('profile-images')
          .getPublicUrl(fileName);
      _imageLink = publicUrl;
      if (kDebugMode) {
        print("✅ تم رفع الصورة وحفظ الرابط بنجاح!");
      }
    } catch (e) {
      if (kDebugMode) {
        print("❌ خطأ: $e");
      }
    }
    emit(AccountUpadted(
      localImage: _localImage,
      imageLink: _imageLink,
    ));
  }
}
