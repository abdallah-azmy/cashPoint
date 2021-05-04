import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Localization {
    Localization(Locale locale) {
        this.locale = locale;
        _localizedValues = null;
    }

    Locale locale;
    static Map<dynamic, dynamic> _localizedValues;

    static Localization of(BuildContext context) {
        return Localizations.of<Localization>(context, Localization);
    }

    String text(String key) {
        return _localizedValues[key] ?? '$key not found';
    }

    static Future<Localization> load(Locale locale) async {
        Localization translations = new Localization(locale);
        String jsonContent =
        await rootBundle.loadString("assets/langs/${locale.languageCode}.json");
        _localizedValues = json.decode(jsonContent);
        return translations;
    }

    get currentLanguage => locale.languageCode;
}

class AppLocalizationDelegate extends LocalizationsDelegate<Localization> {
    const AppLocalizationDelegate();

    @override
    bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

    @override
    Future<Localization> load(Locale locale) => Localization.load(locale);

    @override
    bool shouldReload(AppLocalizationDelegate old) => false;
}
