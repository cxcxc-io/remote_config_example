import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

import './firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  String welcomeMessage = "Welcome to My App";

  void remoteConfigInit() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      // 如果獲取操作超過1分鐘未完成，則會被終止。
      fetchTimeout: const Duration(minutes: 1),
      // 每隔1分鐘，取一次遠端資料
      minimumFetchInterval: const Duration(minutes: 1),
    ));

    await remoteConfig.setDefaults(const {
      "welcome_message": "哈囉, 大家好!",
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    remoteConfigInit();
  }

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });
    await remoteConfig.fetchAndActivate();
    // 更新欢迎消息
    setState(() {
      welcomeMessage = remoteConfig.getString('welcome_message');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              // 設置會變的文字
              welcomeMessage,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
