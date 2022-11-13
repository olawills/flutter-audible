import 'package:audible/utils/picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pdf_text/pdf_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();

  FlutterTts tts = FlutterTts();
  void speak({String? text}) async {
    await tts.speak(text!);
  }

  void stop() async {
    await tts.stop();
  }

  void pause() async {
    await tts.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Read Aloud'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
            ),
            onPressed: () {
              controller.clear();
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.stop,
            ),
            onPressed: () {
              stop();
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.stop,
            ),
            onPressed: () {
              stop();
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.mic,
            ),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                speak(text: controller.text.trim());
              }
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: TextFormField(
          controller: controller,
          maxLines: MediaQuery.of(context).size.height.toInt(),
          decoration: const InputDecoration(
              border: InputBorder.none, label: Text('Enter text..')),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          pickFile().then((value) async {
            if (value != '') {
              PDFDoc doc = await PDFDoc.fromPath(value);
              final text = await doc.text;

              controller.text = text;
            }
          });
        },
        label: const Text('Pick Pdf or File'),
      ),
    );
  }
}
