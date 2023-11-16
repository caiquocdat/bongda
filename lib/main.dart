import 'package:bongda/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';  


void main() {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bóng Đá',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<List<dynamic>>(
        future: Future.wait([fetchData(), fetchIPInfo()]),
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final appSettings = snapshot.data?[0] as AppSettings;
            final ipInfo = snapshot.data?[1] as IPInfoLearn;
            print(ipInfo.country);
            print(appSettings.appVersion);
            if (appSettings.appVersion == '0') {
              if (ipInfo.country != 'VN') {
                return MyHomePage();
              } else {
                return HomeScreen();
              }
            } else {
              return MyHomePage(); 
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Lỗi: ${snapshot.error}'),
            );
          }
          return Container();
        },
      ),
    );
  }
   Future<IPInfoLearn> fetchIPInfo() async {
    final response = await http.get(Uri.parse('https://ipinfo.io/json'));

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      print('oke');
      return IPInfoLearn.fromJson(jsonMap);
    } else {
      throw Exception('Không thể lấy thông tin IP nguoi dung.');
    }
  }
  Future<AppSettings> fetchData() async {
    final String url = 'http://45.32.19.162/apithai2/get_setting_dq1.php';
    final Map<String, String> data = {
      'secret_key': '0A83425hWdn#@^I6ccrgo19Y',
    };

    final response = await http.post(
      Uri.parse(url),
      body: data,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final appSettings = AppSettings.fromJson(jsonResponse);
      return appSettings;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Màu trong suốt cho thanh trạng thái
      statusBarIconBrightness: Brightness.dark, // Màu sáng cho các biểu tượng trên thanh trạng thái
      systemNavigationBarColor: Colors.transparent,
    ));
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => home()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img_theme_splash.png"), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          // Your other widgets
        ),
      ),
    );
  }
}

