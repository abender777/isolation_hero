import 'package:isolationhero/theme/app_theme.dart';
import 'package:isolationhero/views/introduction/introduction_view.dart';

import 'core/locator.dart';
import 'core/providers.dart';
import 'core/services/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  await LocatorInjector.setupLocator();
  runApp(MainApplication());
}

class MainApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderInjector.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        navigatorKey: locator<NavigatorService>().navigatorKey,
        home: IntroductionView(),
      ),
    );
  }
}
