import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';
import 'viewmodels/welcome_viewmodel.dart';
import 'views/welcome_screen.dart';
import 'views/onboarding_screen.dart';
import 'views/details_screen.dart';
import 'utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WelcomeViewModel(),
      child: Consumer<WelcomeViewModel>(
        builder: (context, viewModel, child) {
          return MaterialApp(
            title: 'Financio',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primaryGreen,
              ),
              useMaterial3: true,
              fontFamily: 'Roboto',
            ),
            locale: viewModel.currentLocale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('hi'),
              Locale('te'),
              Locale('ta'),
              Locale('bn'),
              Locale('mr'),
              Locale('gu'),
              Locale('kn'),
            ],
            initialRoute: '/',
            routes: {
              '/': (context) => const WelcomeScreen(),
              '/onboarding': (context) => const OnboardingScreen(),
              '/details': (context) => const DetailsScreen(),
            },
          );
        },
      ),
    );
  }
}
