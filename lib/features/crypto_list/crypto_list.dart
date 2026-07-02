import 'package:flutter/material.dart';

import '../../router/router.dart';
import '../../theme/theme.dart';

export 'view/view.dart';

class CryptocurrenciesListApp extends StatelessWidget {
  const CryptocurrenciesListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CryptoCurrenciesList',
      theme: darkTheme,
      routes: routes,
    );
  }
}