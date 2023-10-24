import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ondago/api/user_bloc.dart';
import 'package:ondago/models/user_model.dart';

class SearchPage extends StatefulWidget {

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    fetchUsers();
    super.initState();
  }

  List<UserModel> totalUsers = [];

  void search(String searchQuery) {
    List<UserModel> searchResult = [];

    userBloc.userController.sink.add(searchResult);

    if (searchQuery.isEmpty) {
      userBloc.userController.sink.add(searchResult);
      return;
    }
    for (var user in totalUsers) {
      if(user.first!.toLowerCase().contains(searchQuery.toLowerCase()) ||
      user.last!.toLowerCase().contains(searchQuery.toLowerCase())) {
        searchResult.add(user);
      }
    }
    userBloc.userController.sink.add(totalUsers);
  }

  Future<void> fetchUsers() async {
    const url = 'https://randomuser.me/api/?results=10';
    http.Response response = await http.get(Uri.parse(url));

    // on 200 OK response
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      final List dlist = body["results"];
      totalUsers = dlist.map((model) =>
          UserModel.fromJson(model)).toList();
      userBloc.userController.sink.add(totalUsers);
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white12,
        body: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            /// search banner ///
            Container(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (text) => search(text),
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.search),
                  hintText: 'Search',
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 20
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 3.1, color: Colors.red),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.green),
                  ),
                ),
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const Text(
                  'Users',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            /// data display widget ///
            Expanded(child: usersWidget())
          ],
        ),
      ),
    );
  }

  Widget usersWidget() {
    return StreamBuilder(
      stream: userBloc.userController.stream,
      builder: (
          BuildContext buildContext,
          AsyncSnapshot<List<UserModel>> snapshot
          ) {
        if (snapshot == null) {
          return const CircularProgressIndicator();
        }
        return snapshot.connectionState == ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator(),)
            : ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      leading: Image.network("${snapshot.data![index].picture}"),
                      title: Text(
                        "${snapshot.data![index].first} ${snapshot.data![index].last}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        "${snapshot.data![index].phone}"
                      ),
                      trailing: Text(
                        "${snapshot.data![index].gender}"
                      ),

                    )
                  );
                }
        );
      }
    );
  }
}
