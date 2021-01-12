import 'package:flutter/material.dart';
//import 'package:twilio_sms_in_flutter/.env';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}
// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomeScreen(),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  TwilioFlutter twilioFlutter;

  //
  @override
  void initState() {
    twilioFlutter = TwilioFlutter(
        accountSid: DotEnv().env['TWILIO_ACCOUNT_SID'],
        authToken: DotEnv().env['TWILIO_ACCOUNT_SID'],
        twilioNumber: '+13*********');
    super.initState();
    print(DotEnv().env['TWILIO_ACCOUNT_SID']);
  }

  void sendSms() async {
    twilioFlutter.sendSMS(
        toNumber: '+911111111111',
        messageBody: 'Hii everyone this is a demo of\nflutter twilio sms.');
  }

  void getSms() async {
    var data = await twilioFlutter.getSmsList();
    print(data);
    await twilioFlutter.getSMS(DotEnv().env['TWILIO_ACCOUNT_SID']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Twilio Send SMS'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Press the button to send SMS.',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendSms,
        tooltip: 'Send Sms',
        child: Icon(Icons.send),
      ),
    );
  }
}
