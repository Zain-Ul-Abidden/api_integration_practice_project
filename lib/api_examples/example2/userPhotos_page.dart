import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:user_api_integration_practice/api_constant.dart';
import 'package:user_api_integration_practice/api_examples/example2/userPhotos_modal_class.dart';

class UserPhotos extends StatefulWidget {
  const UserPhotos({super.key});

  @override
  State<UserPhotos> createState() => _UserPhotosState();
}

class _UserPhotosState extends State<UserPhotos> {
  List<UserPhotosModal> photoList = [];
  late Future<List<UserPhotosModal>> futurePhotos;
  Future<List<UserPhotosModal>> fetchPhotos() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.photosEndpoint);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var photosData = jsonDecode(response.body.toString());
        for (Map<String, dynamic> i in photosData) {
          photoList.add(UserPhotosModal.fromJson(i));
        }
        return photoList;
      } else {
        throw Exception('Could not Fetch Data');
      }
    } catch (ex) {
      print(ex.toString());
      throw Exception(ex.toString());
    }
  }

  @override
  void initState() {
    futurePhotos = fetchPhotos();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
        future: futurePhotos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: photoList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                        backgroundImage: NetworkImage(photoList[index].url)),
                    title: Text(
                      photoList[index].albumId.toString(),
                    ),
                    subtitle: Text(photoList[index].title, maxLines: 1,),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
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
      )),
    );
  }
}
