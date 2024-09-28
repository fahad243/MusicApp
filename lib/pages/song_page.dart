import 'package:flutter/material.dart';
import 'package:music_player/components/neu_box.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // custom app bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // back button
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    // title
                    const Text("P L A Y L I S T"),
                    // menu button
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.menu),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                // album art
                NeuBox(
                  child: Column(
                    children: [
                      // image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset("assets/images/sample1.jpg"),
                      ),

                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // song and artist name
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "So Sick",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text("Mayo"),
                              ],
                            ),

                            // heart icon for liking
                            Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                // song duration progress
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // start time
                          Text("0:00"),

                          // shuffle icon
                          Icon(Icons.shuffle),

                          // repeat icon
                          Icon(Icons.repeat),

                          // end time
                          Text("0.00"),
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 0),
                        ),
                        child: Slider(
                          min: 0,
                          max: 100,
                          value: 50,
                          activeColor: Colors.green,
                          onChanged: (value) {},
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // playback controls
                Row(
                  children: [
                    // skip previous
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: const NeuBox(
                          child: Icon(Icons.skip_previous),
                        ),
                      ),
                    ),
                    const SizedBox(width: 26),
                    // play/pause
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {},
                        child: const NeuBox(
                          child: Icon(Icons.play_arrow),
                        ),
                      ),
                    ),

                    const SizedBox(width: 26),
                    // skip forward
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: const NeuBox(
                          child: Icon(Icons.skip_next),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
