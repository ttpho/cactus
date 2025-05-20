import 'package:cactus/cactus.dart';

CactusContext? cactusContext;

const String promptTranlate = """
I want you to act as an English translator, spelling corrector and improver. I will speak to you in any language and you will detect the language, translate it and answer in the corrected and improved version of my text, in English. I want you to replace my simplified A0-level words and sentences with more beautiful and elegant, upper level English words and sentences. Keep the meaning same, but make them more literary. I want you to only reply the correction, the improvements and nothing else, do not write explanations.
""";

const String baseModelUrl =
    'https://huggingface.co/unsloth/SmolLM2-135M-Instruct-GGUF/resolve/main/SmolLM2-135M-Instruct-Q8_0.gguf';

class LLMModel {
  String latestResult = "";
  CactusContext? cactusContext;

  LLMModel._();

  static Future<LLMModel> create() async {
    final instance = LLMModel._();
    await instance._initialize();
    return instance;
  }

  Future<void> _initialize() async {
    try {
      final initParams = CactusInitParams(
        modelUrl: baseModelUrl,
        onInitProgress: (progress, message, isError) {
          print(
            'Init Progress: $message (${progress != null ? (progress * 100).toStringAsFixed(1) + '%' : 'N/A'})',
          );
        },
      );
      cactusContext = await CactusContext.init(initParams);
    } catch (e) {
      print("Failed to initialize model: $e");
      rethrow;
    }
  }

  Future<String?> tranlate(
    String text,
    Function(String?) onPartialCallback,
    Function(String?) onCompleteCallback,
  ) async {
    final messages = [
      ChatMessage(role: 'system', content: promptTranlate.trim()),
      ChatMessage(role: 'user', content: text.trim()),
    ];
    final completionParams = CactusCompletionParams(
      messages: messages,
      stopSequences: ['<|im_end|>'],
      onNewToken: (token) {
        onPartialCallback(token);
        return true; // Continue generation
      },
    );
    final result = await cactusContext?.completion(completionParams);
    onCompleteCallback(result?.text);
    cactusContext?.free();
    return result?.text;
  }
}
