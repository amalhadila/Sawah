import 'package:flutter/material.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/features/create_tour.dart/presentation/model/get_all_landmarks_by_govern_model.dart';
import 'package:graduation/features/create_tour.dart/presentation/views/widgets/travel_info.dart';

class Language {
  final String name;
  final String nativeName;

  Language({required this.name, required this.nativeName});
}

class LanguageSelectionScreen extends StatefulWidget {
  final List<Landmark> landmarks;
  final String selectedGovernorate;

  const LanguageSelectionScreen({
    Key? key,
    required this.selectedGovernorate,
    required this.landmarks,
  }) : super(key: key);

  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  final List<Language> languages = [
    Language(name: "Afrikaans", nativeName: "Afrikaans"),
    Language(name: "Amharic", nativeName: "አማርኛ"),
    Language(name: "Arabic", nativeName: "العربية"),
    Language(name: "Aymara", nativeName: "Aymar"),
    Language(name: "Azerbaijani", nativeName: "Azərbaycanca"),
    Language(name: "Belarusian", nativeName: "Беларуская"),
    Language(name: "Bulgarian", nativeName: "Български"),
    Language(name: "Bislama", nativeName: "Bislama"),
    Language(name: "Bengali", nativeName: "বাংলা"),
    Language(name: "Bosnian", nativeName: "Bosanski"),
    Language(name: "Catalan", nativeName: "Català"),
    Language(name: "Chinese", nativeName: "中文"),
    Language(name: "Croatian", nativeName: "Hrvatski"),
    Language(name: "Czech", nativeName: "Čeština"),
    Language(name: "Danish", nativeName: "Dansk"),
    Language(name: "Dutch", nativeName: "Nederlands"),
    Language(name: "English", nativeName: "English"),
    Language(name: "Estonian", nativeName: "Eesti"),
    Language(name: "Finnish", nativeName: "Suomi"),
    Language(name: "French", nativeName: "Français"),
    Language(name: "German", nativeName: "Deutsch"),
    Language(name: "Greek", nativeName: "Ελληνικά"),
    Language(name: "Hebrew", nativeName: "עברית"),
    Language(name: "Hindi", nativeName: "हिन्दी"),
    Language(name: "Hungarian", nativeName: "Magyar"),
    Language(name: "Icelandic", nativeName: "Íslenska"),
    Language(name: "Indonesian", nativeName: "Bahasa Indonesia"),
    Language(name: "Italian", nativeName: "Italiano"),
    Language(name: "Japanese", nativeName: "日本語"),
    Language(name: "Kazakh", nativeName: "Қазақ тілі"),
    Language(name: "Korean", nativeName: "한국어"),
    Language(name: "Latvian", nativeName: "Latviešu"),
    Language(name: "Lithuanian", nativeName: "Lietuvių"),
    Language(name: "Macedonian", nativeName: "Македонски"),
    Language(name: "Malay", nativeName: "Bahasa Melayu"),
    Language(name: "Norwegian", nativeName: "Norsk"),
    Language(name: "Persian", nativeName: "فارسی"),
    Language(name: "Polish", nativeName: "Polski"),
    Language(name: "Portuguese", nativeName: "Português"),
    Language(name: "Romanian", nativeName: "Română"),
    Language(name: "Russian", nativeName: "Русский"),
    Language(name: "Serbian", nativeName: "Српски"),
    Language(name: "Slovak", nativeName: "Slovenčina"),
    Language(name: "Slovenian", nativeName: "Slovenščina"),
    Language(name: "Spanish", nativeName: "Español"),
    Language(name: "Swahili", nativeName: "Kiswahili"),
    Language(name: "Swedish", nativeName: "Svenska"),
    Language(name: "Thai", nativeName: "ไทย"),
    Language(name: "Turkish", nativeName: "Türkçe"),
    Language(name: "Ukrainian", nativeName: "Українська"),
    Language(name: "Urdu", nativeName: "اردو"),
    Language(name: "Vietnamese", nativeName: "Tiếng Việt"),
    Language(name: "Welsh", nativeName: "Cymraeg"),
    Language(name: "Zulu", nativeName: "isiZulu"),
  ];

  List<String> selectedLanguages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kbackgroundcolor,
        title: Text(
          'Landmark name',
          style: TextStyle(color: kmaincolor,fontSize: 19,fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kmaincolor,
            size: 22,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Which languages should the guide speak?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: neutralColor3,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final language = languages[index];
                  final isSelected =
                      selectedLanguages.contains(language.name);
                  return ListTile(
                    title: Text(language.name,
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(language.nativeName),
                    trailing: isSelected
                        ? Icon(Icons.check, color: kmaincolor)
                        : null,
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedLanguages.remove(language.name);
                        } else {
                          selectedLanguages.add(language.name);
                        }
                      });
                    },
                  );
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 80),
              child: ElevatedButton(
                onPressed: selectedLanguages.isNotEmpty
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TravelInfo(
                              selectedGovernorate:
                                  widget.selectedGovernorate,
                              selectedLanguages: selectedLanguages,
                              selectedLandmarks: widget.landmarks,
                            ),
                          ),
                        );
                      }
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please, select your language')),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kmaincolor,
                  minimumSize: Size.fromHeight(48),
                ),
                child: const Text('Next',
                    style: TextStyle(
                        color: kbackgroundcolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
