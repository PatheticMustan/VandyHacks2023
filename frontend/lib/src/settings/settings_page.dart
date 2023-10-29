import 'package:flutter/material.dart';
import 'package:auth0_flutter/auth0_flutter.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Credentials? _credentials;

  late Auth0 auth0;

  @override
  void initState() {
    super.initState();
    auth0 = Auth0('dev-cbb8kj1p6znfxp8m.us.auth0.com',
        'HcB8v5Iw4E65ootKqtXdASqIO7B7mb3x');
  }

  @override
  Widget build(BuildContext context) {
    if (_credentials == null) {
      return Center(
          child: ElevatedButton(
              onPressed: () async {
                final credentials =
                    await auth0.webAuthentication(scheme: "demo").login();

                setState(() {
                  _credentials = credentials;
                });
              },
              child: const Text("Log in")));
    } else {
      return Center(
          child: ElevatedButton(
              onPressed: () async {
                await auth0.webAuthentication().logout();

                setState(() {
                  _credentials = null;
                });
              },
              child: const Text("Log out")));
    }
  }
}
