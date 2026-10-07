import 'package:flutter/material.dart';
import 'package:mymoviezz/apiservce.dart';
import 'package:mymoviezz/detailspage.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: homepage()));
}

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<dynamic> _movies = [];
  bool _isLoading = false;

  void searchMovies(String text) async {
    if (text.isEmpty) return;
    setState(() {
      _isLoading = true;
    });
    try {
      final result = await ApiService.searchMovies(text);
      setState(() {
        _movies = result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: const Color.fromARGB(255, 225, 230, 141),
        centerTitle: true,
        title: Text(
          "MyMoviez",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.8,
          ),
        ),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search movies',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onChanged: (text) {
              searchMovies(text);
            },
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator()) //True part
                : GridView.builder(
                    //False part
                    padding: const EdgeInsets.all(10.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                        ),
                    itemCount: _movies.length,
                    itemBuilder: (context, index) {
                      final movie = _movies[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => detailspage(movie: movie),
                            ),
                          );
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(
                                  "https://image.tmdb.org/t/p/w500${movie["poster_path"]}",
                                  width: 100,
                                  height: 125,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  movie["title"] ?? 'No title',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(movie["release_date"] ?? "Not available"),
                                Text('⭐ ${movie["vote_average"] ?? 0}'),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
