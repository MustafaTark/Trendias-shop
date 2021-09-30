import 'package:flutter/material.dart';
import 'package:practice/models/http_exception.dart';
import 'package:practice/providers/auth.dart';
import 'package:practice/screens/auth_screen.dart';
import 'package:practice/widgets/home.dart';
import 'package:provider/provider.dart';

class NewAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            NewAuth(),
          ],
        ),
      ),
    );
  }
}

class NewAuth extends StatefulWidget {
  NewAuth({Key? key}) : super(key: key);

  @override
  _NewAuthState createState() => _NewAuthState();
}

class _NewAuthState extends State<NewAuth> {
  bool _seePassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'userName': '',
    'phoneNumber': '',
  };
  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
    super.initState();
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error Occurred'),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'))
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _authData['email']!.trim();
    _authData['password']!.trim();
    _formKey.currentState!.save();
    try {
      await Provider.of<Auth>(context, listen: false).signUp(
        _authData['email'].toString(),
        _authData['password'].toString(),
        _authData['userName'].toString(),
        _authData['phoneNumber'].toString(),
        '',
      );
    } on HttpExceptions catch (error) {
      var errorMessage = 'Authentication failed ';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not avalid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password';
      } else if (error.toString().contains('MISSING_PASSWORD')) {
        errorMessage = 'missing password';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Could not authenticate you. Please try again later';
      print(error);
      _showErrorDialog(errorMessage);
    }
    if (Provider.of<Auth>(context, listen: false).isAuth) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => Home(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Text(
              'TreShop.',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black38),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/google.PNG',
                      width: 60,
                      height: 30,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Connect With Google',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black38),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/facebook.webp',
                      width: 60,
                      height: 30,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Connect With Facebook',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  child: const Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                const Text(
                  'Or Continue With Email',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.5,
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                const Expanded(
                  child: const Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 600,
              constraints: const BoxConstraints(minHeight: 320),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 380,
                        child: TextFormField(
                          controller: _userNameController,
                          cursorColor: Theme.of(context).accentColor,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.redAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            focusColor: Theme.of(context).accentColor,
                            fillColor: Theme.of(context).accentColor,
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(end: 12.0),
                              child: Icon(
                                Icons.person,
                                color: _focusNodes[0].hasFocus
                                    ? Theme.of(context).accentColor
                                    : Colors.black38,
                              ),
                            ),
                            labelText: 'Username',
                            labelStyle: const TextStyle(
                                color: Colors.grey, fontSize: 17),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Required';
                            }
                          },
                          onSaved: (value) {
                            _authData['userName'] = value!;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 380,
                        child: TextFormField(
                          controller: _phoneNumberController,
                          cursorColor: Theme.of(context).accentColor,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.redAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(end: 12.0),
                              child: Icon(
                                Icons.phone,
                                color: _focusNodes[0].hasFocus
                                    ? Theme.of(context).accentColor
                                    : Colors.black38,
                              ),
                            ),
                            labelText: 'Phone Number',
                            labelStyle: const TextStyle(
                                color: Colors.grey, fontSize: 17),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Required';
                            }
                          },
                          onSaved: (value) {
                            _authData['phoneNumber'] = value!;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 380,
                        child: TextFormField(
                          controller: _emailController,
                          cursorColor: Colors.redAccent,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.redAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            focusColor: Theme.of(context).accentColor,
                            fillColor: Theme.of(context).accentColor,
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(end: 12.0),
                              child: Icon(
                                Icons.email,
                                color: _focusNodes[0].hasFocus
                                    ? Theme.of(context).accentColor
                                    : Colors.black38,
                              ),
                            ),
                            labelText: 'Email',
                            labelStyle: const TextStyle(
                                color: Colors.grey, fontSize: 17),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Invalid email!';
                            }
                          },
                          onSaved: (value) {
                            _authData['email'] = value!;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 380,
                        child: TextFormField(
                          controller: _passwordController,
                          cursorColor: Colors.redAccent,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.redAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(end: 12.0),
                              child: Icon(
                                Icons.lock,
                                color: _focusNodes[0].hasFocus
                                    ? Theme.of(context).accentColor
                                    : Colors.black38,
                              ),
                            ),
                            suffixIcon: Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(end: 12.0),
                              child: IconButton(
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: _focusNodes[0].hasFocus
                                      ? Theme.of(context).accentColor
                                      : Colors.black38,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _seePassword = !_seePassword;
                                  });
                                },
                              ),
                            ),
                            hoverColor: Colors.redAccent,
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                                color: Colors.grey, fontSize: 17),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.redAccent)),
                          ),
                          obscureText: _seePassword,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 5) {
                              return 'Password is too short!';
                            }
                          },
                          onSaved: (value) {
                            _authData['password'] = value!;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 380,
                        child: TextFormField(
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.redAccent, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              labelText: 'Confirm Password',
                              labelStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 17),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value != _passwordController.text) {
                                return 'Passwords do not match!';
                              }
                            }),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          _submit();
                        },
                        child: Container(
                          width: 380,
                          padding: const EdgeInsets.all(20),
                          //margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.redAccent),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 750,
          left: 20,
          child: Row(
            children: [
              const Text('you have account?'),
              TextButton(
                child: const Text(
                  ' login',
                  style: const TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => AuthScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
