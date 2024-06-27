

import 'package:flutter/material.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/features/create_tour.dart/presentation/views/widgets/travel_info.dart';





class Language {
  final String name;
  final String flag;
  final String nativeName;

  Language({required this.name, required this.flag, required this.nativeName});
}

class LanguageSelectionScreen extends StatefulWidget {
  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
   final List<Language> languages = [
    Language(name: "Afrikaans", flag: "assets/flags/za.png", nativeName: "Afrikaans"),
    Language(name: "Amharic", flag: "assets/flags/et.png", nativeName: "አማርኛ"),
    Language(name: "Arabic", flag: "assets/flags/sa.png", nativeName: "العربية"),
    Language(name: "Aymara", flag: "assets/flags/bo.png", nativeName: "Aymar"),
    Language(name: "Azerbaijani", flag: "assets/flags/az.png", nativeName: "Azərbaycanca"),
    Language(name: "Belarusian", flag: "assets/flags/by.png", nativeName: "Беларуская"),
    Language(name: "Bulgarian", flag: "assets/flags/bg.png", nativeName: "Български"),
    Language(name: "Bislama", flag: "assets/flags/vu.png", nativeName: "Bislama"),
    Language(name: "Bengali", flag: "assets/flags/bd.png", nativeName: "বাংলা"),
    Language(name: "Bosnian", flag: "assets/flags/ba.png", nativeName: "Bosanski"),
    Language(name: "Catalan", flag: "assets/flags/es.png", nativeName: "Català"),
    Language(name: "Chinese", flag: "assets/flags/cn.png", nativeName: "中文"),
    Language(name: "Croatian", flag: "assets/flags/hr.png", nativeName: "Hrvatski"),
    Language(name: "Czech", flag: "assets/flags/cz.png", nativeName: "Čeština"),
    Language(name: "Danish", flag: "assets/flags/dk.png", nativeName: "Dansk"),
    Language(name: "Dutch", flag: "assets/flags/nl.png", nativeName: "Nederlands"),
    Language(name: "English", flag: "assets/flags/us.png", nativeName: "English"),
    Language(name: "Estonian", flag: "assets/flags/ee.png", nativeName: "Eesti"),
    Language(name: "Finnish", flag: "assets/flags/fi.png", nativeName: "Suomi"),
    Language(name: "French", flag: "assets/flags/fr.png", nativeName: "Français"),
    Language(name: "German", flag: "assets/flags/de.png", nativeName: "Deutsch"),
    Language(name: "Greek", flag: "assets/flags/gr.png", nativeName: "Ελληνικά"),
    Language(name: "Hebrew", flag: "assets/flags/il.png", nativeName: "עברית"),
    Language(name: "Hindi", flag: "assets/flags/in.png", nativeName: "हिन्दी"),
    Language(name: "Hungarian", flag: "assets/flags/hu.png", nativeName: "Magyar"),
    Language(name: "Icelandic", flag: "assets/flags/is.png", nativeName: "Íslenska"),
    Language(name: "Indonesian", flag: "assets/flags/id.png", nativeName: "Bahasa Indonesia"),
    Language(name: "Italian", flag: "assets/flags/it.png", nativeName: "Italiano"),
    Language(name: "Japanese", flag: "assets/flags/jp.png", nativeName: "日本語"),
    Language(name: "Kazakh", flag: "assets/flags/kz.png", nativeName: "Қазақ тілі"),
    Language(name: "Korean", flag: "assets/flags/kr.png", nativeName: "한국어"),
    Language(name: "Latvian", flag: "assets/flags/lv.png", nativeName: "Latviešu"),
    Language(name: "Lithuanian", flag: "assets/flags/lt.png", nativeName: "Lietuvių"),
    Language(name: "Macedonian", flag: "assets/flags/mk.png", nativeName: "Македонски"),
    Language(name: "Malay", flag: "assets/flags/my.png", nativeName: "Bahasa Melayu"),
    Language(name: "Norwegian", flag: "assets/flags/no.png", nativeName: "Norsk"),
    Language(name: "Persian", flag: "assets/flags/ir.png", nativeName: "فارسی"),
    Language(name: "Polish", flag: "assets/flags/pl.png", nativeName: "Polski"),
    Language(name: "Portuguese", flag: "assets/flags/pt.png", nativeName: "Português"),
    Language(name: "Romanian", flag: "assets/flags/ro.png", nativeName: "Română"),
    Language(name: "Russian", flag: "assets/flags/ru.png", nativeName: "Русский"),
    Language(name: "Serbian", flag: "assets/flags/rs.png", nativeName: "Српски"),
    Language(name: "Slovak", flag: "assets/flags/sk.png", nativeName: "Slovenčina"),
    Language(name: "Slovenian", flag: "assets/flags/si.png", nativeName: "Slovenščina"),
    Language(name: "Spanish", flag: "assets/flags/es.png", nativeName: "Español"),
    Language(name: "Swahili", flag: "assets/flags/ke.png", nativeName: "Kiswahili"),
    Language(name: "Swedish", flag: "assets/flags/se.png", nativeName: "Svenska"),
    Language(name: "Thai", flag: "assets/flags/th.png", nativeName: "ไทย"),
    Language(name: "Turkish", flag: "assets/flags/tr.png", nativeName: "Türkçe"),
    Language(name: "Ukrainian", flag: "assets/flags/ua.png", nativeName: "Українська"),
    Language(name: "Urdu", flag: "assets/flags/pk.png", nativeName: "اردو"),
    Language(name: "Vietnamese", flag: "assets/flags/vn.png", nativeName: "Tiếng Việt"),
    Language(name: "Welsh", flag: "assets/flags/gb-wls.png", nativeName: "Cymraeg"),
    Language(name: "Zulu", flag: "assets/flags/za.png", nativeName: "isiZulu"),
  ];

  @override
    Set<String> selectedLanguages = {};

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kbackgroundcolor,
        title: Text('Landmark name',style: TextStyle(fontWeight: FontWeight.w600),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Which languages should the guide speak?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final language = languages[index];
                  final isSelected = selectedLanguages.contains(language.name);
                  return ListTile(
                    title: Text(language.name, style: TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(language.nativeName),
                    trailing: isSelected ? Icon(Icons.check, color: kmaincolor) : null,
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
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 60),
              child: ElevatedButton(
                onPressed: () {
                   Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => TravelInfo()),
  );
                },
                child: Text('Next', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kmaincolor, 
                  minimumSize: Size.fromHeight(50), 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}