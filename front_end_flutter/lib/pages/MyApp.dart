import 'package:flutter/cupertino.dart';
import 'package:front_end_flutter/pages/root_page.dart';
import 'package:front_end_flutter/states/userModel.dart';
import 'package:provider/provider.dart';



class MyApp extends StatelessWidget {
const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: RootPage()
    );
  }
}