import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pedometer/pedometer.dart';
import 'package:step_counter_app/models/achievement.dart';
import 'package:step_counter_app/screens/achievement_detailed.dart';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

final db = FirebaseFirestore.instance;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';

  @override
  void initState() {
    super.initState();
    initPlatformState();

    setAchievements();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  void setAchievements() async {
    final usersRef = db.collection('users');
    final userRef = usersRef.doc(FirebaseAuth.instance.currentUser!.uid);
    final achievementsRef = userRef.collection('achievements');
    final snapshot = await achievementsRef.get();

    if (snapshot.docs.isEmpty) {
      final achievements = await achievementsRef.add(
        {
          'title': 'First logged in',
          'description':
              'You have successfully entered the program for the first time',
          'image':
              'https://firebasestorage.googleapis.com/v0/b/flutter-step-counter.appspot.com/o/achievements%2Fdate.png?alt=media&token=a489cf2b-ff47-43d2-99a3-b76417150256',
          'isAchieved': true
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 200,
              ),
              Text(
                'Today\'s Steps',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                _steps,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              const Spacer(),
              Text(
                'Achievements',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('achievements')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final achievements = snapshot.data!.docs;

                    return GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      children: [
                        ...achievements.map(
                          (e) => InkWell(
                            onTap: () {
                              if (e['isAchieved']) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AchievementDetailedScreen(
                                      achievement: Achievement(
                                          title: e['title'],
                                          description: e['description'],
                                          image: e['image'],
                                          isAchieved: e['isAchieved']),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(e['title']),
                                  Image.network(e['image'],
                                      height: 70,
                                      opacity: (e['isAchieved'])
                                          ? const AlwaysStoppedAnimation(1)
                                          : const AlwaysStoppedAnimation(.5))
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
