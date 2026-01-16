import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'greeting': 'Hello!',
      'welcome_message': 'Welcome to your financial journey',
      'learn_language': 'Learn in your language',
      'earn_rewards': 'Earn rewards',
      'chat_friends': 'Chat with friends',
      'start_button': 'Let\'s Start',
      'what_do_you_do': 'What do you do?',
      'farmer': 'Farmer',
      'business': 'Business',
      'worker': 'Worker',
      'homemaker': 'Homemaker',
      'continue_button': 'Continue',
      'language': 'EN',
      'details_and_info': 'Details and Information',
      'education': 'Education',
      'no_formal': 'No Formal',
      'primary': 'Primary',
      'secondary': 'Secondary',
      'annual_income': 'Annual Income',
      'income_low': '< ₹50,000',
      'income_medium': '₹50,000 - ₹1,00,000',
      'income_high': '> ₹1,00,000',
      'start_learning': 'Start Learning',
    },
    'hi': {
      'greeting': 'नमस्ते!',
      'welcome_message': 'आपके वित्तीय सफर में स्वागत है',
      'learn_language': 'आपने भाषा में सीखें',
      'earn_rewards': 'इनाम पाएं',
      'chat_friends': 'मित्रों से बात करें',
      'start_button': 'शुरू करें',
      'what_do_you_do': 'आप क्या करते हैं?',
      'farmer': 'किसान',
      'business': 'व्यापारी',
      'worker': 'मजदूर',
      'homemaker': 'गृहिणी',
      'continue_button': 'आगे बढ़ें',
      'language': 'HI',
      'details_and_info': 'शौडी और जानकारी',
      'education': 'शिक्षा',
      'no_formal': 'बिना शिक्षा / No Formal',
      'primary': 'प्राथमिक / Primary',
      'secondary': 'माध्यमिक / Secondary',
      'annual_income': 'वार्षिक आय',
      'income_low': '< ₹50,000',
      'income_medium': '₹50,000 - ₹1,00,000',
      'income_high': '> ₹1,00,000',
      'start_learning': 'सीखना शुरू करें',
    },
    'te': {
      'greeting': 'నమస్కారం!',
      'welcome_message': 'మీ ఆర్థిక ప్రయాణానికి స్వాగతం',
      'learn_language': 'మీ భాషలో నేర్చుకోండి',
      'earn_rewards': 'బహుమతులు సంపాదించండి',
      'chat_friends': 'స్నేహితులతో చాట్ చేయండి',
      'start_button': 'ప్రారంభించండి',
      'what_do_you_do': 'మీరు ఏమి చేస్తున్నారు?',
      'farmer': 'రైతు',
      'business': 'వ్యాపారం',
      'worker': 'కూలీ',
      'homemaker': 'గృహిణి',
      'continue_button': 'కొనసాగించు',
      'language': 'TE',
      'details_and_info': 'వివరాలు మరియు సమాచారం',
      'education': 'విద్య',
      'no_formal': 'అధికారిక విద్య లేదు',
      'primary': 'ప్రాథమిక',
      'secondary': 'మాధ్యమిక',
      'annual_income': 'వార్షిక ఆదాయం',
      'income_low': '< ₹50,000',
      'income_medium': '₹50,000 - ₹1,00,000',
      'income_high': '> ₹1,00,000',
      'start_learning': 'నేర్చుకోవడం ప్రారంభించండి',
    },
    'ta': {
      'greeting': 'வணக்கம்!',
      'welcome_message': 'உங்கள் நிதிப் பயணத்திற்கு வரவேற்கிறோம்',
      'learn_language': 'உங்கள் மொழியில் கற்றுக்கொள்ளுங்கள்',
      'earn_rewards': 'வெகுமதிகளைப் பெறுங்கள்',
      'chat_friends': 'நண்பர்களுடன் அரட்டை',
      'start_button': 'தொடங்குவோம்',
      'what_do_you_do': 'நீங்கள் என்ன செய்கிறீர்கள்?',
      'farmer': 'விவசாயி',
      'business': 'வணிகம்',
      'worker': 'தொழிலாளி',
      'homemaker': 'இல்லத்தரசி',
      'continue_button': 'தொடரவும்',
      'language': 'TA',
      'details_and_info': 'விவரங்கள் மற்றும் தகவல்',
      'education': 'கல்வி',
      'no_formal': 'முறையான கல்வி இல்லை',
      'primary': 'முதன்மை',
      'secondary': 'இடைநிலை',
      'annual_income': 'ஆண்டு வருமானம்',
      'income_low': '< ₹50,000',
      'income_medium': '₹50,000 - ₹1,00,000',
      'income_high': '> ₹1,00,000',
      'start_learning': 'கற்றலைத் தொடங்குங்கள்',
    },
    'bn': {
      'greeting': 'নমস্কার!',
      'welcome_message': 'আপনার আর্থিক যাত্রায় স্বাগতম',
      'learn_language': 'আপনার ভাষায় শিখুন',
      'earn_rewards': 'পুরস্কার অর্জন করুন',
      'chat_friends': 'বন্ধুদের সাথে চ্যাট করুন',
      'start_button': 'শুরু করুন',
      'what_do_you_do': 'আপনি কি করেন?',
      'farmer': 'কৃষক',
      'business': 'ব্যবসা',
      'worker': 'শ্রমিক',
      'homemaker': 'গৃহিণী',
      'continue_button': 'এগিয়ে যান',
      'language': 'BN',
      'details_and_info': 'বিস্তারিত এবং তথ্য',
      'education': 'শিক্ষা',
      'no_formal': 'কোন আনুষ্ঠানিক শিক্ষা নেই',
      'primary': 'প্রাথমিক',
      'secondary': 'মাধ্যমিক',
      'annual_income': 'বার্ষিক আয়',
      'income_low': '< ₹50,000',
      'income_medium': '₹50,000 - ₹1,00,000',
      'income_high': '> ₹1,00,000',
      'start_learning': 'শেখা শুরু করুন',
    },
    'mr': {
      'greeting': 'नमस्कार!',
      'welcome_message': 'आपल्या आर्थिक प्रवासात स्वागत आहे',
      'learn_language': 'तुमच्या भाषेत शिका',
      'earn_rewards': 'बक्षिसे मिळवा',
      'chat_friends': 'मित्रांशी गप्पा मारा',
      'start_button': 'सुरु करूया',
      'what_do_you_do': 'तुम्ही काय करता?',
      'farmer': 'शेतकरी',
      'business': 'व्यापार',
      'worker': 'कामगार',
      'homemaker': 'गृहिणी',
      'continue_button': 'पुढे चला',
      'language': 'MR',
      'details_and_info': 'तपशील आणि माहिती',
      'education': 'शिक्षण',
      'no_formal': 'औपचारिक शिक्षण नाही',
      'primary': 'प्राथमिक',
      'secondary': 'माध्यमिक',
      'annual_income': 'वार्षिक उत्पन्न',
      'income_low': '< ₹50,000',
      'income_medium': '₹50,000 - ₹1,00,000',
      'income_high': '> ₹1,00,000',
      'start_learning': 'शिकणे सुरू करा',
    },
    'gu': {
      'greeting': 'નમસ્તે!',
      'welcome_message': 'તમારી નાણાકીય મુસાફરીમાં સ્વાગત છે',
      'learn_language': 'તમારી ભાષામાં શીખો',
      'earn_rewards': 'પુરસ્કારો મેળવો',
      'chat_friends': 'મિત્રો સાથે ચેટ કરો',
      'start_button': 'ચાલો શરૂ કરીએ',
      'what_do_you_do': 'તમે શું કરો છો?',
      'farmer': 'ખેડૂત',
      'business': 'વેપાર',
      'worker': 'મજૂર',
      'homemaker': 'ગૃહિણી',
      'continue_button': 'આગળ વધો',
      'language': 'GU',
      'details_and_info': 'વિગતો અને માહિતી',
      'education': 'શિક્ષણ',
      'no_formal': 'કોઈ ઔપચારિક શિક્ષણ નથી',
      'primary': 'પ્રાથમિક',
      'secondary': 'માધ્યમિક',
      'annual_income': 'વાર્ષિક આવક',
      'income_low': '< ₹50,000',
      'income_medium': '₹50,000 - ₹1,00,000',
      'income_high': '> ₹1,00,000',
      'start_learning': 'શીખવાનું શરૂ કરો',
    },
    'kn': {
      'greeting': 'ನಮಸ್ಕಾರ!',
      'welcome_message': 'ನಿಮ್ಮ ಹಣಕಾಸಿನ ಪ್ರಯಾಣಕ್ಕೆ ಸುಸ್ವಾಗತ',
      'learn_language': 'ನಿಮ್ಮ ಭಾಷೆಯಲ್ಲಿ ಕಲಿಯಿರಿ',
      'earn_rewards': 'ಬಹುಮಾನಗಳನ್ನು ಗಳಿಸಿ',
      'chat_friends': 'ಸ್ನೇಹಿತರೊಂದಿಗೆ ಚಾಟ್ ಮಾಡಿ',
      'start_button': 'ಪ್ರಾರಂಭಿಸೋಣ',
      'what_do_you_do': 'ನೀವು ಏನು ಮಾಡುತ್ತೀರಿ?',
      'farmer': 'ರೈತ',
      'business': 'ವ್ಯಾಪಾರ',
      'worker': 'ಕಾರ್ಮಿಕ',
      'homemaker': 'ಗೃಹಿಣಿ',
      'continue_button': 'ಮುಂದುವರಿಸಿ',
      'language': 'KN',
      'details_and_info': 'ವಿವರಗಳು ಮತ್ತು ಮಾಹಿತಿ',
      'education': 'ಶಿಕ್ಷಣ',
      'no_formal': 'ಔಪಚಾರಿಕ ಶಿಕ್ಷಣವಿಲ್ಲ',
      'primary': 'ಪ್ರಾಥಮಿಕ',
      'secondary': 'ಮಾಧ್ಯಮಿಕ',
      'annual_income': 'ವಾರ್ಷಿಕ ಆದಾಯ',
      'income_low': '< ₹50,000',
      'income_medium': '₹50,000 - ₹1,00,000',
      'income_high': '> ₹1,00,000',
      'start_learning': 'ಕಲಿಯಲು ಪ್ರಾರಂಭಿಸಿ',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'hi', 'te', 'ta', 'bn', 'mr', 'gu', 'kn'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
