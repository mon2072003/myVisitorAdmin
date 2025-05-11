import 'dart:convert';
import 'dart:developer';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:my_visitor_admin/services/notifications/send_notifications.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SendNotifactionsSendView extends StatefulWidget {
  const SendNotifactionsSendView({super.key});
  static String id = 'SendNotifactionsSendView';
  @override
  // ignore: library_private_types_in_public_api
  _sendNotifactionsSendViewState createState() =>
      _sendNotifactionsSendViewState();
}

// ignore: camel_case_types
class _sendNotifactionsSendViewState extends State<SendNotifactionsSendView> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subTitlecontroller = TextEditingController();

  String accessToken = '';

  getToken() async {
    var mytoken = await FirebaseMessaging.instance.getToken();
    log('My token ================  ${mytoken.toString()}');
  }

  @override
  void initState() {
    getToken();
    super.initState();
    getAccessToken();
  }

  Future<void> getAccessToken() async {
    try {
      final serviceAccountJson =
          await rootBundle.loadString('assets/admin.json');

      final accountCredentials = ServiceAccountCredentials.fromJson(
        json.decode(serviceAccountJson),
      );

      const scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

      final client = http.Client();
      try {
        final accessCredentials =
            await obtainAccessCredentialsViaServiceAccount(
          accountCredentials,
          scopes,
          client,
        );

        setState(() {
          accessToken = accessCredentials.accessToken.data;
        });

        log('Access Token: $accessToken');
      } catch (e) {
        log('Error obtaining access token: $e');
      } finally {
        client.close();
      }
    } catch (e) {
      log('Error loading service account JSON: $e');
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    subTitlecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Notification'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: [
          Image.asset("images/bell.png",height: 200,width: 200,),
          SizedBox(height: 20,),
          CustomTextFrom(
            hint: '',
            label: "title",
            controller: titleController,
            onChanged: (value) {
              titleController.text = value;
            },
          ),
          SizedBox(height: 10,),
          CustomTextFrom(
            hint: '',
            label: "subtitle",
            controller: subTitlecontroller,
            onChanged: (value) {
              subTitlecontroller.text = value;
            },
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CustomSendButton(
              label: 'Send',
              color: Colors.deepOrange,
              txtcolor: Colors.white,
              onTap: () async {
                try {
                  await NotificationsServices().sendNotification(
                    titleController.text,
                    subTitlecontroller.text,
                    accessToken,
                  );
            
                  showCustomAlert(
                      context: context,
                      type: AlertType.success,
                      title: '',
                      description: 'Send done',
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          titleController.clear();
                          subTitlecontroller.clear();
                        });
                      },
                      actionTitle: 'Ok');
            
                  log('send message done');
                } catch (e) {
                  log('send message err:$e');
                }
              },
            ),
          ),
          // IconButton(onPressed: () async{
          //       await FirebaseMessaging.instance
          //                         .subscribeToTopic(notifiGroup);
                            






          // }, icon: Icon(Icons.import_contacts))
          // IconButton(
          //     onPressed: () async {
          //       await NotificationsServices().sendNotification(
          //           'welcome', 'can i help you?', accessToken);
          //       log('send message done');
          //     },
          //     icon: Icon(
          //       Icons.import_contacts,
          //       size: 150,
          //     )),
        ],
      ),
    );
  }
}

class CustomSendButton extends StatelessWidget {
  const CustomSendButton({
    super.key,
    this.onTap,
    required this.label,
    this.width,
    this.color,
    this.txtcolor,
  });
  final void Function()? onTap;
  final String label;
  final double? width;
  final Color? color;
  final Color? txtcolor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: width ?? 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white,
          ),
          // gradient: LinearGradient(colors: mixColors),
          color: color ?? Colors.blueAccent,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: txtcolor ?? Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextFrom extends StatefulWidget {
  const CustomTextFrom({
    super.key,
    this.onChanged,
    required this.label,
    required this.hint,
    this.hide = false,
    this.validator,
    this.isPasswordField = false,
    this.controller,
    this.enabel = true,
  });
  final void Function(String)? onChanged;
  final String label, hint;
  final bool hide;
  final bool? enabel;
  final String? Function(String?)? validator;
  final bool isPasswordField;
  final TextEditingController? controller;
  @override
  State<CustomTextFrom> createState() => _CustomTextFromState();
}

class _CustomTextFromState extends State<CustomTextFrom> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'complete fields';
              }
              return null;
            },
        onChanged: widget.onChanged,
        obscureText: widget.isPasswordField ? _isObscure : false,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          focusColor: Colors.black,
          filled: true,
          fillColor: Colors.white,
          floatingLabelBehavior: FloatingLabelBehavior.never, // Add this line
          label: Text(
            widget.label,
            style: TextStyle(
              color: Colors.orange,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          hintText: widget.hint,
          enabled: widget.enabel ?? true,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                    color: Colors.orange,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                )
              : null,
          hintStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

final outlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.black),
  borderRadius: const BorderRadius.all(Radius.circular(16)),
);


void showCustomAlert({
  required BuildContext context,
  required AlertType type,
  required String title,
  required String description,
  required VoidCallback onPressed,
  required String actionTitle,
  Function? closeFunction,
}) {
  Alert(
    context: context,
    type: type,
    title: title,
    desc: description,
    onWillPopActive: true,
    closeFunction: closeFunction,
    style: const AlertStyle(
      backgroundColor: Colors.black,
      titleStyle: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
      descStyle: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
    ),
    buttons: [
      DialogButton(
        onPressed: onPressed,
        width: 120,
        color: Colors.orange,
        child: Text(
          actionTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  ).show();
}

// void showErrorAlert(BuildContext context) {
//   Alert(
//     context: context,
//     type: AlertType.error,
//     title: "Error",
//     desc: "Flutter is more awesome with RFlutter Alert.",
//     buttons: [
//       DialogButton(
//         child: Text(
//           "COOL",
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//         onPressed: () => Navigator.pop(context),
//         width: 120,
//       ),
//     ],
//   ).show();
// }
