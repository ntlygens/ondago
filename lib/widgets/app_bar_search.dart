import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ondago/api/user_bloc.dart';
import 'package:ondago/models/user_model.dart';

class AppBarSesrch extends StatefulWidget {

  @override
  _AppBarSesrchState createState() => _AppBarSesrchState();
}

class _AppBarSesrchState extends State<AppBarSesrch> {
  @override
  void initState() {
    // fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white12,
        appBar: AppBar(
          centerTitle: true,
          // title: Text("Home"),
          title: Container (
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {

                      },
                    ),
                    hintText: "Search...",
                    border: InputBorder.none
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context)
                    .pop(),
                icon: const Icon(Icons.search)
            )
          ],
          // toolbarHeight: 100,
          /*hasTitle: true,
              hasBackArrow: true,
              hasHdrImg: true,
              headerImage: _headerImage,*/
        ),
        body: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            /// search banner ///
            /*Container(
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
            Expanded(child: usersWidget())*/
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
