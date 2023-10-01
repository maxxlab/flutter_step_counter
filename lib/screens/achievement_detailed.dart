import 'package:flutter/material.dart';
import 'package:step_counter_app/models/achievement.dart';

class AchievementDetailedScreen extends StatelessWidget {
  const AchievementDetailedScreen({required this.achievement, super.key});

  final Achievement achievement;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(achievement.title),
      ),
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                  children: [
            Image.network(achievement.image, height: 300,),
            SizedBox(height: 10,),
            Text(achievement.description, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,)
                  ],
                ),
          ),),
    );
  }
}
