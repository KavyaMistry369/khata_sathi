import 'dart:async';

import 'package:flutter/material.dart';

import '../../utils/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  myTimer() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      Navigator.of(context).pushReplacementNamed(MyRoutes.home);
    });
  }

  @override
  void initState() {
    super.initState();
    myTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(16),child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("lib/views/assets/logo.png",width: 100,),
              const SizedBox(width: 20,),
              const Text("Khata Sathi",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
            ],
          ),
          const SizedBox(height: 50,),
          const LinearProgressIndicator(color: Colors.deepPurple,backgroundColor: Colors.white,),
        ],
      ),),
    );
  }
}
