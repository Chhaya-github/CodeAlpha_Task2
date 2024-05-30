import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

void main() => runApp(const Quote_Generator());

class Quote_Generator extends StatefulWidget {
  const Quote_Generator({super.key});

  @override
  State<Quote_Generator> createState() => _Quote_GeneratorState();
}

class _Quote_GeneratorState extends State<Quote_Generator> {
  final String quoteURL = "https://api.adviceslip.com/advice";
  String Quote = 'Random Quote';

  generateQuote() async {
    var res = await http.get(Uri.parse(quoteURL));
    var result = jsonDecode(res.body);
    print(result["slip"]["advice"]);
    setState(() {
      Quote = result["slip"]["advice"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          title: const Text('Random Quote Generator', style: TextStyle(color: Colors.white),),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(Quote,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.pink),
                    backgroundColor: MaterialStateProperty.all(Colors.pinkAccent)
                  ),
                  onPressed: (){
                    generateQuote();
                  },
                  child: const Text('Generate Quote', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15, color: Colors.white),),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.pink),
                    backgroundColor: MaterialStateProperty.all(Colors.pinkAccent)
                ),
                onPressed: (){
                  Share.share(Quote);
                },
                child: const Text('Share Quote', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15, color: Colors.white),),
              )
            ],
          ),
        )
      ),
    );
  }
}
