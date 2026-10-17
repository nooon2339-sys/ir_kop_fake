import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() => runApp(const IRKopApp());

class IRKopApp extends StatelessWidget {
  const IRKopApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IR KOP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF050505),
        textTheme: GoogleFonts.orbitronTextTheme(Theme.of(context).textTheme),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isConnected = false;
  bool isConnecting = false;
  String displayIp = "0.0.0.0";

  void toggleConnection() {
    if (isConnected) {
      setState(() {
        isConnected = false;
        isConnecting = false;
        displayIp = "0.0.0.0";
      });
    } else {
      setState(() {
        isConnecting = true;
      });
      Timer(const Duration(seconds: 2), () {
        setState(() {
          isConnecting = false;
          isConnected = true;
          displayIp = "185.143.233.${(DateTime.now().second % 250) + 1}";
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "IR KOP",
          style: GoogleFonts.orbitron(
            color: const Color(0xFF00FF41),
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isConnecting ? "CONNECTING..." : (isConnected ? "CONNECTED" : "DISCONNECTED"),
              style: TextStyle(
                color: isConnected ? const Color(0xFF00FF41) : (isConnecting ? Colors.orange : const Color(0xFFFF003C)),
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ).animate(target: isConnecting ? 1 : 0).shimmer(duration: 1.seconds),
            
            const SizedBox(height: 40),
            
            GestureDetector(
              onTap: isConnecting ? null : toggleConnection,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isConnected ? const Color(0xFF00FF41) : (isConnecting ? Colors.orange : const Color(0xFFFF003C)),
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (isConnected ? const Color(0xFF00FF41) : (isConnecting ? Colors.orange : const Color(0xFFFF003C))).withOpacity(0.3),
                      blurRadius: 40,
                      spreadRadius: 10,
                    )
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.power_settings_new,
                    size: 80,
                    color: isConnected ? const Color(0xFF00FF41) : (isConnecting ? Colors.orange : const Color(0xFFFF003C)),
                  ),
                ),
              ).animate(target: isConnecting ? 1 : 0).scale(begin: const Offset(1,1), end: const Offset(1.1, 1.1)).then().scale(begin: const Offset(1.1,1.1), end: const Offset(1,1)),
            ),
            
            const SizedBox(height: 50),
            
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF111111),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFF00BFFF).withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  const Text("IP ADDRESS", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 5),
                  Text(
                    displayIp,
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 500.ms),
          ],
        ),
      ),
    );
  }
}
