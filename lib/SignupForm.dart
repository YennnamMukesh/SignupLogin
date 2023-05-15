import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Comm/genLoginSignupHeader.dart';
import 'Comm/genTextFormField.dart';
import 'DbHelper.dart';
import 'LoginForm.dart';
import 'UserModel.dart';

class BusinessReg extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<BusinessReg> {
  final _formKey = new GlobalKey<FormState>();

  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _regEmail = TextEditingController();
  final _businessName = TextEditingController();
  final _dateController = TextEditingController();
  final _address = TextEditingController();
  final _State = TextEditingController();
  final _Country = TextEditingController();
  final _City = TextEditingController();
  final _LandlineNo = TextEditingController();
  final _MobileNo = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();
  var dbHelper;
  final formatter = DateFormat("MM-dd-yyyy");
  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  signUp() async {
    String firstName = _firstName.text;
    String lastName = _lastName.text;
    String regEmail = _regEmail.text;
    String businessName = _businessName.text;
    String businessType = dropdownvalue;
    String dateController = _dateController.text;
    String address = _address.text;
    String Country = _Country.text;
    String State = _State.text;
    String City = _City.text;
    String LandlineNo = _LandlineNo.text;
    String MobileNo = _MobileNo.text;
    String Password = _conPassword.text;
    String cpasswd = _conCPassword.text;

    print("firstName::${firstName}");
    print("lastName::${lastName}");
    print("regEmail::${regEmail}");
    print("businessName::${businessName}");
    print("businessType::${businessType}");
    print("dateController::${dateController}");
    print("address::${address}");
    print("Country::${Country}");
    print("State::${State}");
    print("City::${City}");
    print("LandlineNo::${LandlineNo}");
    print("MobileNo::${MobileNo}");
    print("Password::${Password}");
    print("cpasswd::${cpasswd}");
    //if (_formKey.currentState!.validate()) {
      // if (Password != cpasswd) {
      //   await showAlertDialog(context, "Password does not match");
      // } else {
      print("entry");
    if (Password != cpasswd) {
      await showAlertDialog(context, "Password does not match");
    }
        Map<String, dynamic> row ={
          DbHelper.C_FirstName : "${firstName}",
          DbHelper.C_LstName : "${lastName}",
          DbHelper.C_Email : "${regEmail}",
          DbHelper.C_BusinessName : "${businessName}",
          DbHelper.C_BusinessType : "${businessType}",
          DbHelper.C_DateController : "${dateController}",
          DbHelper.C_address : "${address}",
          DbHelper.C_Country : "${Country}",
          DbHelper.C_State : "${State}",
          DbHelper.C_City : "${City}",
          DbHelper.C_LandlineNo : "${LandlineNo}",
          DbHelper.C_MobileNo : "${MobileNo}",
          DbHelper.C_Password : "${Password}",
        };
        print("row::: ${row}");
         final id = await dbHelper.insert(row);
        // final id = await dbHelper.saveData(uModel.toMap().toString());
        print("Insert Data into Table::: ${id}");
    await RegistrationDone(context, "Registration completed successfully");
        // await dbHelper.saveData(uModel).then((userData) {
        //  // AlertDialog(title:Text("Successfully Saved"));
        //   Navigator.push(
        //       context, MaterialPageRoute(builder: (_) => LoginForm()));
        // }).catchError((error) {
        //   print(error);
        //   //AlertDialog(title:Text("Error: Data Save Fail"));
        //   Text("sorry...");
        // });
     // }

  }
  String dropdownvalue = 'Select Business Type';
  var items = [
    'Select Business Type','Individual','Partnership','Private Limited','Public Limited'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account for Signup'),
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
                  genLoginSignupHeader('Create Bus_Account'),
                  SizedBox(height: 20,),
                  Text("Fill All the details"),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          textColor: Colors.blue,
                          child: Text('Alredy have account?'),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => LoginForm()));
                          },
                        )
                      ],
                    ),
                  ),
                  getTextFormField(
                       controller: _firstName,
                      icon: Icons.person,
                      hintName: 'first_Name'),
                  SizedBox(height: 10.0),
                  getTextFormField(
                       controller: _lastName,
                      icon: Icons.person_outline,
                      inputType: TextInputType.name,
                      hintName: 'last_Name'),
                  SizedBox(height: 10.0),
                  getTextFormField(
                      controller: _regEmail,
                      icon: Icons.email,
                      inputType: TextInputType.emailAddress,
                      hintName: 'Email'),
                  SizedBox(height: 10.0),
                  getTextFormField(
                      controller: _businessName,
                      icon: Icons.store,
                      inputType: TextInputType.emailAddress,
                      hintName: 'BusinessName'),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      width: 300,
                      height: 60,
                      child:DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child:  DropdownButton(
                            value: dropdownvalue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          prefixIcon: IconButton(onPressed: null,icon: Icon(Icons.calendar_today),),
                          hintText: 'Select Date',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        controller: _dateController,
                        validator:(value) {
                          String datevalue = value.toString();
                          if(datevalue.isEmpty){
                            return "Select Date";
                          }
                        },
                        readOnly: true,  // when true user cannot edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(), //get today's date
                              firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101)
                          );
                          if(pickedDate != null ){
                            String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                            print(formattedDate); //formatted date output using intl package =>  2022-07-04
                            setState(() {
                              _dateController.text = formattedDate;
                            });
                          }else{
                            print("Date is not selected");
                          }
                        }
                    ),
                  ),
                  SizedBox(height: 10.0),
                  getTextFormField(
                      controller: _address,
                      icon: Icons.home,
                      inputType: TextInputType.emailAddress,
                      hintName: 'Address'),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _Country,
                    icon: Icons.location_city,
                    hintName: 'Country',
                  ),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _State,
                    icon: Icons.location_city,
                    hintName: 'State',
                  ),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _City,
                    icon: Icons.location_city,
                    hintName: 'City',
                  ),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _LandlineNo,
                    inputType: TextInputType.number,
                    icon: Icons.phone,
                    hintName: 'LandlineNo',
                  ),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _MobileNo,
                    inputType: TextInputType.number,
                    icon: Icons.phone_android,
                    hintName: 'MobileNo',
                  ),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conPassword,
                    icon: Icons.lock,
                    hintName: 'Password',
                    isObscureText: true,
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          prefixIcon: IconButton(onPressed: null,icon: Icon(Icons.lock),),
                          hintText: 'Enter a search term',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        controller: _conCPassword,
                        validator: (val){
                          if(val!.isEmpty)
                            return 'Empty';
                          if(val != _conPassword.text)
                            return 'Not Match';
                          return null;
                        }
                    ),
                  ),
                  // getTextFormField(
                  //   controller: _conCPassword,
                  //   icon: Icons.lock,
                  //   hintName: 'ConfirmPassword',
                  //   isObscureText: true,
                  // ),
                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: FlatButton(
                      child: Text(
                        'Signup',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: ()async{
                        if(!_formKey.currentState!.validate()){
                          return null;
                        }else{
                          await signUp();
                        }
                      },
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30.0),
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
  showAlertDialog(BuildContext context, String msg) {
    AlertDialog alert = AlertDialog(
      title: Text("Here's a message"),
      content: Text("${msg}"),
      actions: [
        CupertinoDialogAction(child: Text("OK"), onPressed: () {
          Navigator.of(context).pop();
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



