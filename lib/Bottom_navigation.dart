import 'package:assesment/TV_Series.dart';
import 'package:assesment/movies.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

int Selectedindex = 0;
final tabs = [
  const TvSeries(),
  const Dem(),
];

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[Selectedindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: Selectedindex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.tv,
              color: Colors.red,
              size: 22,
            ),
            label: "TV Series",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.movie_creation_outlined,
              color: Colors.red,
              size: 22,
            ),
            label: "Movies",
          )
        ],
        onTap: (index) {
          setState(() {
            Selectedindex = index;
          });
        },
      ),
    );
  }
}
