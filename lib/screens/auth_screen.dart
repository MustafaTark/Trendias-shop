import 'package:flutter/material.dart';
import 'package:practice/models/http_exception.dart';
import 'package:practice/providers/auth.dart';
import 'package:practice/screens/new_auth.dart';

import 'package:practice/widgets/home.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            AuthContainer(),
          ],
        ),
      ),
    );
  }
}

class AuthContainer extends StatefulWidget {
  AuthContainer({Key? key}) : super(key: key);

  @override
  _AuthContainerState createState() => _AuthContainerState();
}

class _AuthContainerState extends State<AuthContainer> {
  bool _seePassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
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
    setState(() {});
    try {
      await Provider.of<Auth>(context, listen: false).login(
          _authData['email'].toString(), _authData['password'].toString());
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
    return SafeArea(
      child: Stack(
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
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                      child: const Divider(
                    thickness: 1,
                    color: Colors.black,
                  )),
                  const SizedBox(
                    width: 7,
                  ),
                  const Text(
                    'Or Login With Email',
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
                height: 20,
              ),
              Container(
                height: 400,
                constraints: const BoxConstraints(
                  minHeight: 230,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                              labelStyle:
                                  TextStyle(color: Colors.grey, fontSize: 17),
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
                                ), // myIcon is a 48px-wide widget.
                              ),
                              hoverColor: Colors.redAccent,
                              labelText: 'Password',
                              labelStyle:
                                  TextStyle(color: Colors.grey, fontSize: 17),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.redAccent)),
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
                            child: const Text(
                              'Submit',
                              style: const TextStyle(
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
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          Positioned(
            top: 560,
            left: 20,
            child: Row(
              children: [
                const Text('you don\'t have account?'),
                TextButton(
                  child: const Text(
                    'create new account',
                    style: const TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => NewAuthScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
