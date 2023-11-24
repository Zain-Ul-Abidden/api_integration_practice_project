import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:user_api_integration_practice/api_examples/example1/modal_class.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserModal> userList = [];
  late Future<List<UserModal>> futureUserdata;
  Future<List<UserModal>> fetchUserData() async {
    try {
      // var url = ApiConstants.baseUrl + ApiConstants.userEndpoint;
      var response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        for (Map<String, dynamic> i in data) {
          userList.add(UserModal.fromJson(i));
        }
        return userList;
      } else {
        return Future.error('Could not fetch Data');
      }
    } catch (ex) {
      print(ex.toString());
      return throw Exception('Could not Fetch Data.....');
    }
  }

  @override
  void initState() {
    futureUserdata = fetchUserData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: FutureBuilder(
        future: futureUserdata,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Text('Id: ${userList[index].id}'),
                          Text('Username: ${userList[index].userName}'),
                          Text('Name: ${userList[index].name}'),
                          Text('Email: ${userList[index].email}'),
                          Text(
                             'Address: ${userList[index].address?.city}, ${userList[index].address?.street}, ${userList[index].address?.zipcode}'),
                          const SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error.toString()}');
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    ));
  }
}
