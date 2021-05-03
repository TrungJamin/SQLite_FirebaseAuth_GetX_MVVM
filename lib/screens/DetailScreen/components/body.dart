import 'package:first_project_login_and_register/utils/database.dart';
import 'file:///D:/Dev/Flutter/first_project_login_and_register/lib/models/user_model.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // Future<List<User>> futureUsers; // error: type 'Future<dynamic>' is not a subtype of type 'Future<List<User>>'
  // Future<dynamic> futureUsers;
  Future futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = getUsers();
    print('futureUsers: $futureUsers');
  }

  getUsers() async {
    //  Future<List<User>>
    final userData = await DBProvider.db.users();
    print('DBProvider.db.users(): ${DBProvider.db.users()}');
    // DBProvider.db.users() returns  Future<List<User>> type
    // so why futureUsers with  Future<List<User>> type  cannot be assigned to the value that DBProvider.db.users()
    // returns;
    return userData;
  }

  deleteUser(int id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirmation"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Are you sure want to delete user $id")
                ],
              ),
            ),
            actions: <Widget>[
              new ElevatedButton(
                  onPressed: () {
                    DBProvider.db.deleteUser(id);
                    // Goi ham setState trong nay dc, nhung neu de o ngoai ham
                    // showDialog thi khong dc ?
                    setState(() {
                      futureUsers = getUsers();
                    });
                    Navigator.pop(context); // Quit Dialog
                  },
                  child: Text("Yes")),
              new ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Quit Dialog
                  },
                  child: Text("No"))
            ],
          );
        });
  }

  editUser(User user) {
    TextEditingController usernameController =
        TextEditingController(text: '${user.username}');
    TextEditingController passwordController =
        TextEditingController(text: '${user.password}');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Update user: ${user.id}"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextFormField(
                    controller: usernameController,
                    /* initialValue: user.username,
                  You can't use initialValue and controller at the same time. '
              'So, a better way is to use controller because its constructor does provide you initial value that you can set.*/
                    decoration: InputDecoration(
                        labelText: "username", prefixIcon: Icon(Icons.person)),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        labelText: "password", prefixIcon: Icon(Icons.lock)),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter password';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              new ElevatedButton(
                  onPressed: () {
                    User newUser = User(
                        id: user.id,
                        username: usernameController.text,
                        password: passwordController.text);
                    DBProvider.db.updateUser(newUser);
                    setState(() {
                      futureUsers = getUsers();
                    });
                    Navigator.pop(context); // Quit Dialog
                  },
                  child: Text("Update")),
              new ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Quit Dialog
                  },
                  child: Text("Cancel"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        width: size.width,
        height: size.height,
        child: Center(
          child: FutureBuilder<dynamic>(
            future: futureUsers,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('${snapshot.data}');
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      dynamic user = snapshot.data[index];
                      return Users(
                        user: user,
                        index: index,
                        onDelete: () {
                          deleteUser(user.id);
                        },
                        onEdit: () {
                          editUser(user);
                        },
                      );
                    });
              } else if (snapshot.hasError) {
                Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ));
  }
}

class Users extends StatelessWidget {
  final dynamic user;
  final int index;
  final Function onDelete;
  final Function onEdit;
  const Users({
    Key key,
    this.user,
    this.index,
    this.onDelete,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: (index % 2 == 0) ? Colors.lightBlueAccent : Colors.white,
      width: size.width,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${index + 1}.",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Information(
                      keyy: "id",
                      value: user.id,
                    ),
                    Information(
                      keyy: "username",
                      value: user.username,
                    ),
                    Information(
                      keyy: "password",
                      value: user.password,
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: EditAndDeleteBtns(
                    delete: onDelete,
                    edit: onEdit,
                  ),
                ),
              ],
            ),
            Divider(
              height: 1.5,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}

class EditAndDeleteBtns extends StatelessWidget {
  final dynamic user;
  final Function delete;
  final Function edit;
  const EditAndDeleteBtns({
    Key key,
    this.user,
    this.delete,
    this.edit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          child: Icon(Icons.edit),
          onTap: edit,
        ),
        SizedBox(
          width: size.width * 0.02,
        ),
        GestureDetector(child: Icon(Icons.delete), onTap: delete),
      ],
    );
  }
}

class Information extends StatelessWidget {
  final String keyy;
  final dynamic value;
  const Information({
    Key key,
    this.keyy,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "$keyy: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('${value}'),
        ],
      ),
    );
  }
}
