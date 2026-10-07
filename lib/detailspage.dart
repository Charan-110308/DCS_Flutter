import 'package:flutter/material.dart';
import 'package:mymoviezz/apiservce.dart';

class detailspage extends StatefulWidget {
  final Map<String, dynamic> movie;

  const detailspage({super.key, required this.movie});

  @override
  State<detailspage> createState() => _detailspageState();
}

class _detailspageState extends State<detailspage> {
  bool _isLoading = true;
  String? errorMessage;
  Map<String, dynamic>? details;

  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  void loadDetails() async {
    try {
      final result = await ApiService.getMovieDetails(widget.movie["id"]);
      print("RunTime = ${result["runtime"]}");
      setState(() {
        details = result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Failed to load movie details";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.movie['title']),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  "https://image.tmdb.org/t/p/w500${widget.movie["poster_path"]}",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 16),
                Text(
                  widget.movie['title'],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  "Release Date: ${widget.movie["release_date"] ?? "Not available"}",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Rating: ⭐ ${widget.movie["vote_average"] ?? 0}",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Language: ${widget.movie['original_language'] ?? "Not available"}",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.left,
                ),
                if (details != null)
                  Text(
                    "Runtime: ${details!["runtime"]} minutes",
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                SizedBox(height: 16),
                Text(
                  "Overview: ${widget.movie['overview']}",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
