import 'package:flutter/material.dart';
import 'package:auth0_flutter/auth0_flutter.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title:
                  const Text('Settings', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.blueAccent,
            ),
            body: const Padding(
              padding: EdgeInsets.all(30),
              child: GoogleButton(),
            )));
  }
}

class GoogleButton extends StatefulWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  Credentials? _credentials;
  UserProfile? user;

  late Auth0 auth0;

  @override
  void initState() {
    super.initState();
    auth0 = Auth0('dev-cbb8kj1p6znfxp8m.us.auth0.com',
        'HcB8v5Iw4E65ootKqtXdASqIO7B7mb3x');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        (() {
          if (_credentials == null) {
            return ElevatedButton(
                onPressed: () async {
                  final credentials =
                      await auth0.webAuthentication(scheme: "demo").login();

                  setState(() {
                    _credentials = credentials;
                    user = _credentials?.user;
                  });
                },
                child: const Text("Google Login"));
          } else {
            return ElevatedButton(
                onPressed: () async {
                  await auth0.webAuthentication(scheme: "demo").logout();

                  setState(() {
                    _credentials = null;
                    user = null;
                  });
                },
                child: const Text("Google Logout"));
          }
        }()),
        if (user?.name != null) Text("Welcome, ${user!.name!}"),
        if (user?.email != null) Text(user!.email!)
      ],
    );
  }
}
