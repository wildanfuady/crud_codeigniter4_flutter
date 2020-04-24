import 'package:flutter/material.dart';
import 'package:flutter_crud_ci4/model/user.dart';
import 'package:flutter_crud_ci4/screen/user_create.dart';
import 'package:flutter_crud_ci4/service/user_service.dart';
import 'package:flutter_crud_ci4/util/capitalize.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = UserApiService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Homepage"),),
      body: FutureBuilder(
        future: apiService.getUsers(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<User> users = snapshot.data;
            return _buildListView(users);
          } else {
            return Center(
              child: Container(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => FormUser()) 
          );
        }
      ),
    );
  }

  Widget _buildListView(List<User> users) {
    return  ListView.separated(
      separatorBuilder: (BuildContext context, int i) => Divider(color: Colors.grey[400]),
      itemCount: users.length,
      itemBuilder: (context, index) {
        User user = users[index];
        return ListTile(
          onTap: () {},
          leading: Icon(Icons.people),
          title: Text(user.fullName),
          subtitle: Text(capitalize(user.gender)),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(user.grade.toUpperCase()),
              Text(user.phone)
            ],
          ),
        );  
      },
    );
  }
}