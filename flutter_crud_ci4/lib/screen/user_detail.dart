import 'package:flutter/material.dart';
import 'package:flutter_crud_ci4/model/user.dart';
import 'package:flutter_crud_ci4/service/api_service.dart';
import 'package:flutter_crud_ci4/service/user_service.dart';
import 'package:flutter_crud_ci4/util/capitalize.dart';

class DetailUser extends StatefulWidget {

  final int id;

  DetailUser({@required this.id, Key key}):super(key: key);
  @override
  _DetailUserState createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {

  UserApiService apiService;
  User _user;

  @override
  void initState() {
    apiService = UserApiService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail User"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => {
            Navigator.pop(context),
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit), 
            onPressed: () {}
          ),
          IconButton(
            icon: Icon(Icons.delete), 
            onPressed: () {},
          ),
        ],
      ),
      // body
      body: Center(
        child: FutureBuilder<User>(
          future: apiService.getUserBy(widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none &&
                snapshot.hasData == null) {
              return LinearProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done) {
              
              // tampung data dari server
              _user = snapshot.data;

              // jika data ada / tidak null

              if(_user.id != 0){

                return ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Image.asset(
                        'assets/images/${_user.gender}.png',
                        width: 150.0,
                        height: 150.0,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.account_box),
                      title: Text(_user.fullName),
                      subtitle: const Text('Nama'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(_user.phone),
                      subtitle: const Text('No.Hp'),
                    ),
                    ListTile(
                      leading: Icon(Icons.label),
                      title: Text(capitalize(_user.gender)),
                      subtitle: const Text('Jenis Kelamin'),
                    ),
                    ListTile(
                      leading: Icon(Icons.school),
                      title: Text(_user.grade.toUpperCase()),
                      subtitle: const Text('Jenjang'),
                    ),
                  ],
                );
              // jika data null
              } else {
                return Text("User Not Found");
              }
            } else {
              return Center(
                child: Container(),
              );
            }
          }
        ),
      ),
    );
  }
}