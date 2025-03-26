import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayerScreen extends StatefulWidget {
  final String name= 'Marco';
  final String surname = 'Marcelli';
  final String localVideoPath = 'assets/videos/marco.mp4';
  final Function(int) changeIndexCallback;

  const PlayerScreen(this.changeIndexCallback,{
    // required this.name,
    // required this.surname,
    Key? key,
  }) : super(key: key);



  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.localVideoPath)
      ..initialize().then((_) {
        // _controller.play();
        setState(() {}); // Ricarica il widget quando il video è pronto
      })
      ..setLooping(false); // Il video non deve ripartire automaticamente
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${widget.name} ${widget.surname}",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),

        if (_controller.value.isInitialized)
          Center(
          child: Container(
            width: 100,
            height: 180,
          )
    )
    else  Container(),

        ElevatedButton(
          onPressed: () {
            setState(() {
              _controller.play(); // Avvia il video quando cliccato
              // SeederManager().seed();
            });
          },
          child: const Text('Play Video'),
        ),
      ],
    );
  }
}
