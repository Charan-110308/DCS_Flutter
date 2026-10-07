import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:mymoviezz/loginpage.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');

  print('API key loaded: ${dotenv.env['TMDB_API_KEY']?.isNotEmpty}');

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: loginpage()));
}
