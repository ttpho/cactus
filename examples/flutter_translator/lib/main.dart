import 'package:flutter/material.dart';
import 'package:flutter_translator/inference.dart';

// The main entry point for the application.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LLMModel.create();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Translator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeWidgetPage(),
    );
  }
}

class HomeWidgetPage extends StatefulWidget {
  const HomeWidgetPage({super.key});

  @override
  State<HomeWidgetPage> createState() => _HomeWidgetPageState();
}

class _HomeWidgetPageState extends State<HomeWidgetPage> {
  LLMModel? _llmModel;
  String label = "---";
  @override
  void initState() {
    super.initState();
    _englishTextController.text = "業者間";
  }

  // Controllers for the text input fields.
  final TextEditingController _englishTextController = TextEditingController();
  final ValueNotifier<String> _token = ValueNotifier<String>("");

  @override
  void dispose() {
    // Dispose of the text controllers when the widget is removed from the widget tree.
    _englishTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Languages Translator',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(label),
                ValueListenableBuilder<String>(
                  builder: (BuildContext context, String value, Widget? child) {
                    return Text(value);
                  },
                  valueListenable: _token,
                ),
                // English text input area
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: TextField(
                    controller: _englishTextController,
                    minLines: 2,
                    maxLines: 10, // Allows for unlimited lines
                    decoration: const InputDecoration(
                      hintText: 'Type any thing',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.black54),
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement translation logic here
          print('Translate button pressed!');
          translate(_englishTextController.text.trim());
        },
        child: const Icon(Icons.translate, size: 30), // Translation icon
      ),
    );
  }

  void translate(String text) {
    LLMModel.create().then((value) {
      print("Inint LLMModel done--------------");
      _llmModel = value;

      _llmModel
          ?.tranlate(
            text,
            (token) {
              print("onPartialCallback: $token ");
              _token.value = "$token";
            },
            (param) {
              print("onCompleteCallback: $param ");
              setState(() {
                label = param ?? "!!!";
              });
            },
          )
          .then((value) {})
          .onError((handleError, stackTrace) {
            print(stackTrace);
            setState(() {
              label = stackTrace.toString();
            });
          });
    });
  }
}
