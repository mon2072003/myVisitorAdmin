import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_visitor_admin/generated/l10n.dart';
import 'package:translator/translator.dart';

Future<void> showCustomChatModalSheet({
  required BuildContext context,
  required String userInput,
}) async {
  final context1 = context;
  showModalBottomSheet(
    context: context1,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.smart_toy,
                  color: Colors.deepOrange),
              title: Text(S.of(context).suggest_ai_response),
              onTap: () async {
                Navigator.pop(context);
                String aiResponse = S.of(context).ai_resonse_unavailable;
                try {
                  final ai = FirebaseAI.googleAI().generativeModel(
                  model: 'gemini-2.0-flash',
                  );
                  final result = await ai.generateContent([
                  Content.text(userInput),
                  ]);
                  aiResponse = result.text ?? S.of(context).no_response_available;
                  debugPrint('AI Response: $aiResponse');
                  showModalBottomSheet(
                  context: context1,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView(
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                        Text(aiResponse),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.copy,color: Colors.deepOrange,),
                          label: Text(S.of(context).copy,style: TextStyle(color: Colors.deepOrange),),
                          onPressed: () {
                          Clipboard.setData(ClipboardData(text: aiResponse));
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context1).showSnackBar(
                             SnackBar(content: Text(S.of(context).copied_to_clipboard)),
                          );
                          },
                        ),
                        ],
                      ),
                    );
                  },
                  );
                } catch (e) {
                  aiResponse = 'Error: $e';
                  debugPrint(aiResponse);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.translate, color: Colors.deepOrange),
              title: Text(S.of(context).translate_message),
              onTap: () async {
                Navigator.pop(context);
                final translator = GoogleTranslator();
                String translated = userInput;
                try {
                  translated =
                      (await translator.translate(userInput, to: 'ar')).text;
                  debugPrint('Translated: $translated');
                  showModalBottomSheet(
                  context: context1,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                        child: ListView(
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(translated),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                          icon: const Icon(Icons.copy,color: Colors.deepOrange,),
                          label: Text(S.of(context).copy,style: TextStyle(color: Colors.deepOrange),),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: translated));
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context1).showSnackBar(
                                   SnackBar(content: Text(S.of(context).copied_to_clipboard)),
                                );
                              },
                            ),
                          ],
                        ),
                    );
                  },
                  );
                } catch (e) {
                  translated = 'Translation error: $e';
                  debugPrint(translated);
                }
              },
            ),
          ],
        ),
      );
    },
  );
}
