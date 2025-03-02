import 'package:agora_call/screen/caller_screen.dart';
import 'package:agora_call/screen/permission_screen.dart';
import 'package:agora_call/screen/recieve_call_screen.dart';
import 'package:agora_call/utils/helper/helper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  _checkPermissions() async {
    Helpers.requestPermissions(context).then((status) {
      if (status['microphone'] != PermissionStatus.granted ||
          status['camera'] != PermissionStatus.granted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) {
            return const PermissionScreen();
          }),
          (Route<dynamic> route) => false,
        );
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const FittedBox(child: Text('Agora Call App by Sandeep Shah')),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person_2,
                size: 100,
                color: Colors.green,
              ),
              const Text(
                'Please select your role.',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 60,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const CallerScreen(
                                  isCaller: true,
                                )));
                      },
                      child: const Text('I am a caller',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RecieveCallScreen()));
                      },
                      child: const Text('I am a receiver',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
              const Text('Note: Please be on receiver screen to get call from caller...')
            ],
          ),
        ),
      ),
    );
  }
}
