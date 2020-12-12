import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<AppUsageInfo> _infos = [];

  @override
  void initState() {
    super.initState();
  }

  void getUsageStats() async {
    try {
      DateTime startDate = DateTime(2018, 01, 01);
      DateTime endDate = new DateTime.now();
      List<AppUsageInfo> infos =
          await AppUsage.getAppUsage(DateTime(2020, 12, 12, 13, 53), DateTime(2020, 12, 12, 13, 54));
      List<AppUsageInfo> infos2 =
          await AppUsage.getAppUsage(DateTime(2020, 12, 10, 11, 53), DateTime(2020, 12, 12, 14, 15));
      for (AppUsageInfo x in infos) {
        print(x);
      }
      for (AppUsageInfo x in infos2) {
        print(x);
      }
      setState(() {
        _infos = infos;
      });
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Usage Example'),
          backgroundColor: Colors.green,
        ),
        body: ListView.builder(
            itemCount: _infos.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(_infos[index].appName), trailing: Text(_infos[index].usage.toString()));
            }),
        floatingActionButton:
            FloatingActionButton(onPressed: getUsageStats, child: Icon(Icons.file_download)),
      ),
    );
  }
}
