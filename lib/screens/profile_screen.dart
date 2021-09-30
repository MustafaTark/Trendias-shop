import 'package:flutter/material.dart';
import 'package:practice/providers/theme.dart';
import 'package:practice/screens/details_screen.dart';
import 'package:practice/screens/order_screen.dart';
import 'package:provider/provider.dart';
//import 'package:practice/widgets/home.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isDark = false;
  void _changeThemeMode() {
    setState(() {
      _isDark = !_isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: Container(),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 18,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => DetailsScreen(),
                ),
              );
            },
            child: ListTile(
              title: Text(
                'Detail Profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              leading: Icon(
                Icons.person,
                size: 25,
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => OrdersScreen(),
                ),
              );
            },
            child: ListTile(
              title: Text(
                'My Order',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              leading: Icon(
                Icons.delivery_dining_outlined,
                size: 25,
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          ListTile(
            title: Text(
              'Chat With Us',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            leading: Icon(
              Icons.chat_bubble,
              size: 25,
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          ListTile(
            title: Text(
              'Log Out',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            leading: Icon(
              Icons.logout,
              size: 25,
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          ListTile(
            title: Text(
              'Dark Mode',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            leading: Icon(
              Icons.brightness_4,
              size: 20,
            ),
            trailing: Switch(
              value: _isDark,
              onChanged: (val) {
                _changeThemeMode();
                if (val) {
                  Provider.of<ThemeNotfire>(context, listen: false)
                      .setDarkMode();
                } else {
                  Provider.of<ThemeNotfire>(context, listen: false)
                      .setLightMode();
                }
              },
              activeColor: Theme.of(context).accentColor,
            ),
          ),
          ListTile(
            title: Text(
              'Help',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          ListTile(
            title: Text(
              'Privacy Policy',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
