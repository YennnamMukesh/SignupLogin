import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_project/Comm/genTextFormField.dart';

import 'Comm/comHelper.dart';
import 'Comm/genLoginSignupHeader.dart';
import 'DbHelper.dart';
import 'SignupForm.dart';
import 'endUserReg.dart';
import 'main.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  //Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = new GlobalKey<FormState>();
  final _regEmail = TextEditingController();
  final _conPassword = TextEditingController();
 var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
   // deleteAllData();
    allData();
  }
  void allData()async{
    var data = await dbHelper.query();
    data?.forEach((element) {
      print(element);
    });
  }
  void deleteAllData()async{
    var data = await dbHelper.deleteAllRecords();
    print("deleted::${data}");
  }

  login() async {
    String email = _regEmail.text;
    String passwd = _conPassword.text;
    if (_formKey.currentState!.validate()) {
      print("email::${email}");
      print("passwd::${passwd}");
      Map<String, dynamic> row = {
        DbHelper.C_Email: "${email}",
        DbHelper.C_Password: "${passwd}",
      };
      print("row::: ${row}");
      var loginData = await dbHelper.getLoginUser(email, passwd);
      // final id = await dbHelper.saveData(uModel.toMap().toString());
      print("TrueorFalse::: ${loginData.toString()}");
      if(loginData!=true){
        await RegistrationDone(context, "Login Faild \n$email\n$passwd\n is worng");
      }else{
        await RegistrationDone(context, "Login successfully");
      }

      // await dbHelper.getLoginUser(email, passwd).then((userData) {
      //   if (userData != null) {
      //     setSP(userData).whenComplete(() {
      //       Navigator.pushAndRemoveUntil(
      //           context,
      //           MaterialPageRoute(builder: (_) => HomeForm()),
      //           (Route<dynamic> route) => false);
      //     });
      //   } else {
      //     AlertDialog(title:Text("Error: User Not Found"));
      //   }
      // }).catchError((error) {
      //   print(error);
      //   AlertDialog(title:Text("Error: Login Fail"));
      // });
    }
  }

  // Future setSP(UserModel user) async {
  //   final SharedPreferences sp = await _pref;
  //
  //   sp.setString("user_id", user.user_id);
  //   sp.setString("user_name", user.user_name);
  //   sp.setString("email", user.email);
  //   sp.setString("password", user.password);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with Signup'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  genLoginSignupHeader('Login'),
                  SizedBox(height: 10.0),
                  Text("Welcome back! Login with your credentials"),
                  SizedBox(height: 30.0),
                  getTextFormField(
                      controller: _regEmail,
                      inputType: TextInputType.emailAddress,
                      icon: Icons.person,
                      hintName: 'Email'),
                  SizedBox(height: 20.0),
                  getTextFormField(
                    controller: _conPassword,
                    icon: Icons.lock,
                    hintName: 'Password',
                    isObscureText: true,
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10.0),
                            width: double.infinity,
                            child: FlatButton(
                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: ()async{
                                await login();
                              },
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        Expanded(child: Container(
                          margin: EdgeInsets.all(10.0),
                          width: double.infinity,
                          child: FlatButton(
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => startfile()));
                            },
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),)
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Does not have account? '),
                        FlatButton(
                          textColor: Colors.blue,
                          child: Text('Signup'),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => RadioButton()));
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class RadioButton extends StatefulWidget {
  @override
  _RadioButtonState createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Role'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Business Role:"),
                Radio(
                    value: "radio value",
                    groupValue: "group value",
                    activeColor: Colors.blue,
                    onChanged: (value){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BusinessReg())); //selected value
                    }
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("EndUser Role:"),
                Radio(
                    value: "radio value",
                    groupValue: "group value",
                    activeColor: Colors.blue,
                    onChanged: (value){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  endUserReg())); //selected value
                    }
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

RegistrationDone(BuildContext context, String msg) {
  AlertDialog alert = AlertDialog(
    title: Text("Here's a message"),
    content: Text("${msg}"),
    actions: [
      CupertinoDialogAction(child: Text("OK"), onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => LoginForm()));
      },)

    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}