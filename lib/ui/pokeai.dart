import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/other/global_variables.dart';
import 'package:flutter_pokedex/themes/poke_theme.dart';
import 'package:flutter_pokedex/ui/pokecamera.dart';
import 'package:flutter_pokedex/widgets/bubble_chat.dart';
import 'package:flutter_pokedex/widgets/custom_loader_indicator.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:mime/mime.dart';

import '../services/gemini.dart';

class PokeAI extends StatefulWidget {
  const PokeAI({super.key});

  @override
  State<PokeAI> createState() => _PokeAIState();
}

class _PokeAIState extends State<PokeAI> {

  final GeminiInstance _geminiInstance = GeminiInstance();

  final TextEditingController _searchTEC = TextEditingController();
  final FocusNode _searchFN = FocusNode();

  final ValueNotifier<List<String>> _promptList = ValueNotifier([]);
  final ValueNotifier<bool> _isTyping = ValueNotifier(false);
  final _promptImagesPaths = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: screenHeight,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                reverse: true,
                child: ValueListenableBuilder(
                  valueListenable: _promptList,
                  builder: (BuildContext context, value, Widget? child) {
                    return value.isEmpty
                      ? SizedBox(
                          height: screenHeight / 2,
                          child: Column(
                            children: [
                              Image.asset("assets/images/pokeball.png", width: 180),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text("Ask PokéAI something")
                            ],
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: _generateChatList(value),
                      );
                  }
                ),
              ),
              Container(
                width: screenWidth,
                decoration: BoxDecoration(
                  color: PokeTheme.white,
                ),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: screenWidth - 72,
                      child: TextFormField(
                        controller: _searchTEC,
                        focusNode: _searchFN,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 6,
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                          hintText: "Ask something",
                        ),
                        onChanged: (_) {
                          if (_searchTEC.text != "") {
                            _isTyping.value = true;
                          } else {
                            _isTyping.value = false;
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    ValueListenableBuilder(
                      valueListenable: _isTyping,
                      builder: (BuildContext context, value, Widget? child) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                          child: GestureDetector(
                              onTap: () async {

                                if (value) {
                                  await _askGemini(false);
                                } else {
                                  Navigator.of(originalContext!).push(MaterialPageRoute(builder: (builder) => const PokeCamera())).then((value) async {
                                    if (value != '' && value is String) {
                                      await _askGemini(true, value);
                                    }
                                  });
                                }

                              },
                              child: Icon(
                                  value ? Icons.send_rounded : Icons.camera_alt,
                                  color: PokeTheme.azure
                              )
                          ),
                        );
                      }
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _generateChatList(List<String> list) {
    List<Widget> results = [];
    for (int x=0; x<list.length; x++) {
      if (x % 2 == 0) {
        if (_promptImagesPaths[x] != '') {
          results.add(
              BubbleChat(text: list[x], isQuestion: true, imagePath: _promptImagesPaths[x])
          );
        } else {
          results.add(
              BubbleChat(text: list[x], isQuestion: true, imagePath: '')
          );
        }
      } else {
        if (list[x] == "") {
          results.add(
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
              child: CustomLoaderIndicator(color: PokeTheme.green, strokeWidth: 2, radius: 12),
            )
          );
        } else {
          results.add(
            BubbleChat(text: list[x], isQuestion: false, imagePath: '')
          );
        };
      }
    }
    results.add(
      const SizedBox(
        height: 52,
      )
    );
    return results;
  }

  Future _askGemini(bool gotImage, [String? imagePath]) async {
    List<String> temp = [];
    try {
        String answer = "";
        String question = "";
        String prompt = "";
        GenerateContentResponse? geminiResponse;

        if (gotImage == true) {
          question = "Find any Pokémon info in this image";
          prompt = "Find any detailed Pokémon info in this image. Ignore anything else for example text, buttons, environment. Answer in English. If you can't find anything then answer \"Can't find anything Pokémon related in this image.\"";
        } else {
          question = _searchTEC.text;
          prompt = "$question."
              "If what i asked is in a language that differs from english, ignore the question and answer \"Please ask any questions in English.\"."
              "If what i asked is not Pokémon related than ignore the question and answer \"Your question isn't Pokémon related.\"";
        }

        temp = [..._promptList.value, question];
        temp = [...temp, ""];
        _promptList.value = temp;

        if (gotImage == true) {
          _promptImagesPaths.add(imagePath);
          _promptImagesPaths.add("");
        } else {
          _promptImagesPaths.add("");
          _promptImagesPaths.add("");
        }

        _searchTEC.text = "";
        _isTyping.value = false;

        if (gotImage == true) {

          File image = File(imagePath!);
          Uint8List bytes = await image.readAsBytes();
          String? mimeType = lookupMimeType(imagePath, headerBytes: bytes);

          geminiResponse = await _geminiInstance.getPokemonInfo(
              prompt,
              bytes,
              mimeType!
          );
        } else {
          geminiResponse = await _geminiInstance.getPokemonTextInfo(
              prompt
          );
        }

        if (geminiResponse.text != null) {
          answer = geminiResponse.text!;
        } else {
          answer =
          "AI blocked your question, please try again.";
        }

        temp.removeLast();
        temp = [...temp, answer];
        _promptList.value = temp;

    } catch (error) {
      temp.removeLast();
      temp = [
        ...temp,
        "AI blocked your question, please try again."
      ];
      _promptList.value = temp;
      if (kDebugMode) {
        print(error);
      }
    }
  }

}
