import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:front_end_flutter/common/http/ewl.dart';
import 'package:front_end_flutter/components/login_text_field.dart';
import 'package:front_end_flutter/models/index.dart';
import 'package:front_end_flutter/pages/root_page.dart';
import 'package:provider/provider.dart';

import '../../states/userModel.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

const String logoPath = "lib/assets/images/logo.png";

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmedPasswordController = TextEditingController();
  bool _isRegisterPage = false;


  void login() async {
    var username = _usernameController.value.text;
    var password = _passwordController.value.text;
    User? user;
    EasyLoading.show(status: "登录中...");

    user = await EWL().login(username, password);
    Provider.of<UserModel>(context, listen: false).user = user;
    if (user == null) {
      EasyLoading.showError("用户名或密码错误");
    }
    EasyLoading.dismiss();
  }

  void switchPage() {
    setState(() {
      _isRegisterPage = !_isRegisterPage;
    });
  }

  void register() async {
    var username = _usernameController.value.text;
    var password = _passwordController.value.text;
    var confirmedPassword = _confirmedPasswordController.value.text;
    String res = await EWL().register(username, password, confirmedPassword);
    if (res == "成功") {
      EasyLoading.showSuccess("注册成功");
    } else {
      EasyLoading.showError(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              // logo
              Image.asset(
                logoPath,
                height: 100,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "咩背单词",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),

              const SizedBox(
                height: 30,
              ),

              // username 输入框
              LoginTextField(
                controller: _usernameController,
                hintText: '用户名',
                obscureText: false,
                icon: const Icon(
                  Icons.account_circle,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // password 输入框
              LoginTextField(
                controller: _passwordController,
                hintText: '密码',
                obscureText: true,
                icon: Icon(Icons.lock),
              ),
              const SizedBox(
                height: 15,
              ),
              Visibility(
                  visible: _isRegisterPage,
                  child: Column(
                    children: [
                      LoginTextField(
                        controller: _confirmedPasswordController,
                        icon: Icon(Icons.lock),
                        hintText: '确认密码',
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  )),
              //登录按钮
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: ElevatedButton(
                      onPressed: _isRegisterPage ? register : login,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      child: Text(_isRegisterPage ? "注册" : "登录")),
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        child: Text("还没有账号?"),
                        visible: !_isRegisterPage,
                      ),
                      GestureDetector(
                        onTap: switchPage,
                        child: Text(
                          _isRegisterPage ? "立即登录" : "立即注册",
                          style: const TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
