import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission/provider/scheduling_provider.dart';
import 'package:submission/provider/shared_preverence_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: const Text('Setting Page'),
      ),
      body: Consumer<SharedPreferenceProvider>(
        builder: (context, provider, child) {
          return ListView(
            children: [
              Material(
                child: Consumer<SchedulingProvider>(
                  builder: (context, schedule, child) {
                    return ListTile(
                      title: const Text('Daily News'),
                      trailing: Switch.adaptive(
                        value: provider.isReminder,
                        onChanged: (value) {
                          schedule.scheduledNews(value);
                          provider.setDailyNewsStatus(value);
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    ));
  }
}
