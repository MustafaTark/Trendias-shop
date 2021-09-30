import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice/providers/auth.dart';
import 'package:practice/providers/user_details.dart';
import 'package:practice/screens/edit_screen.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool check = false;
  String newPath = '';
  late File _storedImage;
  final ImagePicker _picker = ImagePicker();
  Future<void> _takePicture() async {
    final auth = Provider.of<Auth>(context, listen: false);

    final imageFile = await _picker.pickImage(
      source: ImageSource.camera,
    );

    setState(() {
      newPath = imageFile!.path;
    });
    _storedImage = File(newPath);
    if (_storedImage.path == imageFile!.path) {
      setState(() {
        check = true;
      });
    }
    File _imageFile = File(imageFile.path);
    if (imageFile.path.isEmpty) {
      return;
    }

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    await _imageFile.copy('${appDir.path}/$fileName');
    Provider.of<UserDatails>(context, listen: false)
        .updataUserData('imageUrl', imageFile.path, auth.userId, auth.token);
    Navigator.pop(context);
  }

  Future<void> _choosePicture() async {
    final auth = Provider.of<Auth>(context, listen: false);

    final imageFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      newPath = imageFile!.path;
    });
    _storedImage = File(newPath);
    if (_storedImage.path == imageFile!.path) {
      setState(() {
        check = true;
      });
    }
    File _imageFile = File(imageFile.path);
    if (imageFile.path.isEmpty) {
      return;
    }

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    await _imageFile.copy('${appDir.path}/$fileName');
    Provider.of<UserDatails>(context, listen: false)
        .updataUserData('imageUrl', imageFile.path, auth.userId, auth.token);
    Navigator.pop(context);
  }

  void _putImage() {
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.22,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Profile Picture',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          final auth =
                              Provider.of<Auth>(context, listen: false);
                          Provider.of<UserDatails>(context, listen: false)
                              .updataUserData(
                                  'imageUrl', '', auth.userId, auth.token);
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 23,
                              backgroundImage: AssetImage('assets/delete.png'),
                              backgroundColor: Colors.redAccent,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Delete Image',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      GestureDetector(
                        onTap: _choosePicture,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 23,
                              backgroundImage: AssetImage(
                                'assets/gallery2.png',
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Gallery',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      GestureDetector(
                        onTap: _takePicture,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 23,
                              backgroundImage: AssetImage('assets/camera.png'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Camera',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> labels = ['Username', 'Email', 'Phone Number'];
    final userData = Provider.of<UserDatails>(context).details;
    final List<String> data = [
      userData.username,
      userData.email,
      userData.phoneNumber
    ];
    final auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details Profile',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Future.delayed(Duration.zero, () async {
          await Provider.of<UserDatails>(context, listen: false)
              .getUserDetails(auth.userId, auth.token);
        }),
        builder: (ctx, _) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {},
                child: userData.imageUrl.path == ''
                    ? const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(
                            'https://sothis.es/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png'),
                      )
                    : CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey,
                        backgroundImage: FileImage(userData.imageUrl),
                      ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: _putImage,
                child: Text(
                  'Add Image',
                  style: TextStyle(
                    fontSize: 17,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: labels.length,
                  itemBuilder: (ctx, i) => Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 10,
                          child: Text(
                            labels[i],
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 30,
                          child: Text(
                            data[i],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 30,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) =>
                                      EditScreen(labels[i], data[i]),
                                ),
                              );
                            },
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
