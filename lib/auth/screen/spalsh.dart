import 'package:fixlah/auth/provider/splash_provider.dart';
import 'package:fixlah/config/graphics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<SplashProvider>(
        context,
        listen: false,
      ).checkAuth(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(image: AssetImage(Graphics.logo_primary)),
      ),
    );
  }
}
