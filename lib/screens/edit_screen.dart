import 'package:flutter/material.dart';
import 'package:practice/providers/auth.dart';
import 'package:practice/providers/user_details.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  final String label;
  final String data;
  EditScreen(this.label, this.data);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final newDataController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  String newData = '';
  Future<void> _submit() async {
    _formKey.currentState!.save();
    setState(() {});
    final auth = Provider.of<Auth>(context, listen: false);
    try {
      Future.delayed(Duration.zero, () async {
        await Provider.of<UserDatails>(context, listen: false).updataUserData(
          widget.label,
          newData,
          auth.userId,
          auth.token,
        );
      });
    } catch (err) {
      print(err);
      print(auth.userId);
      print(widget.label);
      print(newData);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit ${widget.label}"),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: newDataController,
                  // initialValue: data,
                  onSaved: (value) {
                    newData = value!;
                  },
                  decoration: InputDecoration(
                    labelText: widget.label,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15, top: 10),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextButton(
                        onPressed: _submit,
                        child: Text(
                          "update",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
