import 'package:flutter/material.dart';
import 'package:flutter_crud_ci4/model/user.dart';
import 'package:flutter_crud_ci4/service/user_service.dart';
import 'package:flutter_crud_ci4/util/capitalize.dart';
import 'package:flutter_crud_ci4/widget/form_label.dart';
import 'package:flutter_crud_ci4/widget/radio_button.dart';

class FormEditUser extends StatefulWidget {

  final User user;
  final int id;

  FormEditUser({@required this.user, @required this.id, Key key}):super(key: key);

  @override
  _FormEditUserState createState() => _FormEditUserState();
}

class _FormEditUserState extends State<FormEditUser> {

  UserApiService apiService;

  static const genders = User.genders; // from domain
  static const grades = User.grades; // from domain

  // upayakan menggunakan global key
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  bool _autovalidate = false;
  // jarak antar form
  double _gap = 16.0;
  // focus node
  FocusNode _fullnameFocus, _phoneFocus;
  // variabel value null
  String _fullname, _gender, _grade, _phone;

  TextEditingController _fullnameController, _phoneController;

  final List<DropdownMenuItem<String>> _gradeItems = grades
    .map((String val) => DropdownMenuItem<String>(
          value: val,
          child: Text(val.toUpperCase()),
        ))
    .toList();

  @override
  void initState() {
    super.initState();
    _gender = 'pria';
    _fullnameFocus = FocusNode();
    _phoneFocus = FocusNode();
    _fullnameController = TextEditingController();
    _phoneController = TextEditingController();

    if(widget.user != null && widget.id != null){
      _fullname = widget.user.fullName;
      _phone = widget.user.phone;
      _gender = widget.user.gender;
      _grade = widget.user.grade;

      _fullnameController.value = TextEditingValue(
        text: widget.user.fullName,
        selection: TextSelection.collapsed(offset: widget.user.fullName.length)
      );

       _phoneController.value = TextEditingValue(
        text: widget.user.phone,
        selection: TextSelection.collapsed(offset: widget.user.phone.length)
      );

    }

    apiService = UserApiService();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _fullnameFocus.dispose();
    _phoneFocus.dispose();
    _fullnameController.dispose();
    _phoneController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  _showSnackBar(message){
    final snackbar = SnackBar(content: Text(message),);
    _scaffoldkey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => {
            Navigator.pop(context),
          },
        ),
        title: Text("Edit User"),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Form(
            // key form as csrf
            key: _formKey,
            autovalidate: _autovalidate,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _fullnameController,
                    focusNode: _fullnameFocus,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nama Lengkap',
                    ),
                    onSaved: (String value) {
                      // will trigger when saved
                      print('onsaved _fullname $value');
                      _fullname = value;
                    },
                    onFieldSubmitted: (term) {
                      _fullnameFocus.unfocus();
                      FocusScope.of(context).requestFocus(_phoneFocus);
                    },
                    validator: (val) {
                      if(val.isEmpty){
                        return "Nama lengkap wajib diisi";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: _gap,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    focusNode: _phoneFocus,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'No. Hp',
                    ),
                    onSaved: (String value) {
                      // will trigger when saved
                      print('onsaved _hone $value');
                      _phone = value;
                    },
                    onFieldSubmitted: (term) {
                      _phoneFocus.unfocus();
                      FocusScope.of(context).requestFocus(_fullnameFocus);
                    },
                    validator: (val) {
                      if(val.isEmpty){
                        return "No hp wajib diisi";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: _gap,
                  ),
                  FormLabel('Jenis Kelamin'),
                  Row(
                    children: genders
                        .map((String val) => RadioButton<String>(
                            value: val,
                            groupValue: _gender,
                            label: Text(capitalize(val)),
                            onChanged: (String value) {
                              setState(() => _gender = value);
                            }))
                        .toList(),
                  ),
                  SizedBox(
                    height: _gap,
                  ),
                  FormLabel('Jenjang'),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: DropdownButton(
                      value: _grade,
                      hint: Text('Pilih jenjang'),
                      items: _gradeItems,
                      isExpanded: true,
                      onChanged: (String value) {
                        setState(() {
                          _grade = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.save,
          color: Colors.white,
        ),
        onPressed: () {
          final form = _formKey.currentState;
          if (form.validate()) {
            // Process data.
            form.save(); // required to trigger onSaved props
            User _user = User();

            if(_grade == null){
              _showSnackBar("Jenjang tidak boleh kosong");
            } else if(_gender == null){
              _showSnackBar("Gender tidak boleh kosong");
            } else {
              _user.fullName = _fullname;
              _user.grade = _grade;
              _user.gender = _gender;
              _user.phone = _phone;
              print(_user);

              // snackbar success dan error
              final onSuccess = (Object success) => Navigator.pop(context);
              final onError = (Object error) => _showSnackBar("Tidak bisa ubah data");
              
              apiService.updateUser(id: widget.user.id, data: _user).then(onSuccess).catchError(onError);
            }
          } else {
            setState(() {
              _autovalidate = true;
            });
          }
        }
      ),
    );
  }
}