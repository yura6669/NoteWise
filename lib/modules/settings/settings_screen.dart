// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notewise/core/di/locator.dart';
import 'package:notewise/modules/auth/auth_screen.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/internet.dart';
import 'package:notewise/modules/resorses/urls.dart';
import 'package:notewise/modules/resorses/utils.dart';
import 'package:notewise/modules/settings/bloc/settings_bloc.dart';
import 'package:notewise/modules/settings/widgets/settings_app_bar.dart';
import 'package:notewise/modules/settings/widgets/text_btn.dart';
import 'package:notewise/modules/settings/widgets/user_info.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = 'setting';
  final String userId;
  const SettingsScreen({required this.userId, super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SettingsBloc _settingsBloc;

  @override
  void initState() {
    _settingsBloc = locator.get();
    _settingsBloc.load(userId: widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _settingsBloc,
      child: BlocListener<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state.isSignedOut) {
            Navigator.pushReplacementNamed(context, AuthScreen.route);
          }
        },
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            if (state.isLoaded) {
              return _builContent(state);
            } else if (state.isLoading) {
              return _buildLoader();
            } else if (state.isNoInternet) {
              return _buildError('No internet connection');
            } else {
              return _buildError('Unknown error');
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoader() {
    return Scaffold(
      backgroundColor: AppColors.textColor.withOpacity(0.5),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildError(String errorMessage) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(errorMessage),
      ),
    );
  }

  Widget _builContent(SettingsState state) {
    return Scaffold(
      appBar: settingsAppBar(context: context, title: 'Settings'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Utils.adaptiveHeight(context, 3),
              horizontal: Utils.adaptiveWidth(context, 2)),
          child: Column(
            children: [
              UserInfo(user: state.user),
              _buildDivider(),
              TextBtn(
                title: 'Privacy policy',
                icon: 'assets/policy.png',
                onTap: () => _onOpenTerms(context, Urls.privacyPolicyUrl),
              ),
              _buildDivider(),
              TextBtn(
                title: 'Terms of service',
                icon: 'assets/terms_conditions.png',
                onTap: () => _onOpenTerms(context, Urls.termsAndConditionsUrl),
              ),
              _buildDivider(),
              TextBtn(
                title: 'Sign out',
                icon: 'assets/sign_out.png',
                onTap: () => _settingsBloc.signOut(),
              ),
              _buildDivider(),
              const Spacer(),
              _buildAppVersion(state.appVersion),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppVersion(String version) {
    return Text(
      'App version: $version',
      style: TextStyle(
        fontSize: Utils.adaptiveWidth(context, 5),
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        color: AppColors.textColor.withOpacity(0.5),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(color: Colors.black, thickness: 1);
  }

  Future<void> _onOpenTerms(BuildContext context, String url) async {
    if (await hasNetwork()) {
      await launchUrl(Uri.parse(url));
    } else {
      noInternetConnection(context);
    }
  }
}
