import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              title: const Text('suggest AI Response'),
              onTap: () async {
                Navigator.pop(context);
                String aiResponse = 'AI response unavailable';
                try {
                  final ai = FirebaseAI.googleAI().generativeModel(
                  model: 'gemini-2.0-flash',
                  );
                  final result = await ai.generateContent([
                  Content.text(userInput),
                  ]);
                  aiResponse = result.text ?? 'No response';
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
                          label: const Text('Copy',style: TextStyle(color: Colors.deepOrange),),
                          onPressed: () {
                          Clipboard.setData(ClipboardData(text: aiResponse));
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context1).showSnackBar(
                            const SnackBar(content: Text('Copied to clipboard')),
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
              title: const Text('Translate Message'),
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
                          label: const Text('Copy',style: TextStyle(color: Colors.deepOrange),),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: translated));
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context1).showSnackBar(
                                  const SnackBar(content: Text('Copied to clipboard')),
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
