import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_notificaciones_ordenes/app/router/app_router.dart';
import 'package:app_notificaciones_ordenes/app/theme/app_theme.dart';
import 'package:app_notificaciones_ordenes/l10n/app_localizations.dart';

class ProductionManagementApp extends ConsumerWidget {
  const ProductionManagementApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Production Management',
      theme: AppTheme.lightTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}