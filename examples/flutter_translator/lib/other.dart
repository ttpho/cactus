import 'package:flutter/material.dart';

// The main entry point for the application.
void main() {
  runApp(const MyApp());
}

// MyApp is a StatelessWidget that sets up the basic MaterialApp.
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

// HomeWidgetPage is a StatefulWidget that represents the main UI screen.
class HomeWidgetPage extends StatefulWidget {
  const HomeWidgetPage({super.key});

  @override
  State<HomeWidgetPage> createState() => _HomeWidgetPageState();
}

// The state class for HomeWidgetPage.
class _HomeWidgetPageState extends State<HomeWidgetPage> {
  // Controllers for the text input fields.
  final TextEditingController _englishTextController = TextEditingController();
  final TextEditingController _spanishTextController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the text controllers when the widget is removed from the widget tree.
    _englishTextController.dispose();
    _spanishTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Background color for the entire screen
      body: Stack(
        children: [
          // Top section with "Write with your finger" and "To Translate"
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Column(
              children: const [
                Text(
                  'Write with your finger',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'To Translate',
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
              ],
            ),
          ),
          // The main white card containing the translator UI
          Positioned(
            top:
                MediaQuery.of(context).size.height *
                0.25, // Adjust position based on screen height
            left: 20,
            right: 20,
            bottom: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  30,
                ), // Rounded corners for the card
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // App bar like section with time and icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '9:00 AM',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: const [
                            Icon(Icons.wifi, size: 20),
                            SizedBox(width: 5),
                            Icon(Icons.signal_cellular_alt, size: 20),
                            SizedBox(width: 5),
                            Icon(Icons.battery_full, size: 20),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Languages Translator',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Language selection buttons
                    Row(
                      children: [
                        Expanded(
                          child: LanguageButton(
                            text: 'English',
                            isSelected: true, // English is selected by default
                            onPressed: () {
                              // Handle English language selection
                            },
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: LanguageButton(
                            text: 'Spanish',
                            isSelected:
                                false, // Spanish is not selected by default
                            onPressed: () {
                              // Handle Spanish language selection
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // English text input area
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: TextField(
                          controller: _englishTextController,
                          maxLines: null, // Allows for unlimited lines
                          expands:
                              true, // Allows the TextField to expand vertically
                          decoration: const InputDecoration(
                            hintText:
                                'There are many variations of passages of\nLorem Ipsum available, but the majority\nhave suffered alteration in some form,\nby injected humour, or randomised words\nwhich don\'t look even slightly b',
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.black54),
                          ),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Spanish text output area (simulated)
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: TextField(
                        controller: _spanishTextController,
                        maxLines: null, // Allows for unlimited lines
                        expands:
                            true, // Allows the TextField to expand vertically
                        readOnly: true, // Make it read-only as it's an output
                        decoration: const InputDecoration(
                          hintText:
                              'Hay muchas variaciones de pasuj de\nLorem Ipsum disponible, pero la mayoría\nhan sufrido alguna alteración, mediante\nhumor inyectado o palabras aleatorias\nque no parecen ni un poco creíbles.',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.black54),
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Floating action button for translation
          Positioned(
            bottom:
                MediaQuery.of(context).size.height * 0.25 -
                30, // Position it slightly above the bottom card
            right: 40,
            child: FloatingActionButton(
              onPressed: () {
                // Implement translation logic here
                print('Translate button pressed!');
              },
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  15,
                ), // Rounded corners for the FAB
              ),
              child: const Icon(
                Icons.compare_arrows,
                size: 30,
              ), // Translation icon
            ),
          ),
        ],
      ),
    );
  }
}

// Custom widget for language selection buttons.
class LanguageButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const LanguageButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: isSelected ? Colors.blue : Colors.black,
        backgroundColor:
            isSelected ? Colors.blue.withOpacity(0.1) : Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            15,
          ), // Rounded corners for the button
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
        elevation: 0, // No shadow for the button
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 16,
        ),
      ),
    );
  }
}
