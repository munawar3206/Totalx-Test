import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:totalxtask/controller/home_provider.dart';
import 'package:totalxtask/view/loginscreens/login_page.dart';
import 'package:totalxtask/view/widget/alertbox.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        return SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.black,
                actions: [
                  IconButton(
                      tooltip: "Logout",
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                      },
                      icon: const Icon(
                        Icons.logout_outlined,
                        color: Colors.redAccent,
                      ))
                ],
              ),
              backgroundColor: const Color.fromARGB(255, 233, 233, 233),
              body: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              homeProvider.setSearchQuery(value);
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              hintText: "Search by name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(top: 10, left: 20),
                                        child: Text(
                                          "Sort",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      ListTile(
                                        leading: IconButton(
                                          onPressed: () {
                                            homeProvider
                                                .setSelectedAgeOption('All');
                                            Navigator.pop(context);
                                          },
                                          icon: homeProvider
                                                      .selectedAgeOption ==
                                                  'All'
                                              ? const Icon(Icons
                                                  .radio_button_on_outlined)
                                              : const Icon(Icons
                                                  .radio_button_off_outlined),
                                        ),
                                        title: const Text('All'),
                                        onTap: () {
                                          homeProvider
                                              .setSelectedAgeOption('All');
                                          Navigator.pop(context);
                                        },
                                        selected:
                                            homeProvider.selectedAgeOption ==
                                                'All',
                                      ),
                                      ListTile(
                                        leading: IconButton(
                                          onPressed: () {
                                            homeProvider
                                                .setSelectedAgeOption('Elder');
                                            Navigator.pop(context);
                                          },
                                          icon: homeProvider
                                                      .selectedAgeOption ==
                                                  'Elder'
                                              ? const Icon(Icons
                                                  .radio_button_on_outlined)
                                              : const Icon(Icons
                                                  .radio_button_off_outlined),
                                        ),
                                        title: const Text('Age : Elder'),
                                        onTap: () {
                                          homeProvider
                                              .setSelectedAgeOption('Elder');
                                          Navigator.pop(context);
                                        },
                                        selected:
                                            homeProvider.selectedAgeOption ==
                                                'Elder',
                                      ),
                                      ListTile(
                                        leading: IconButton(
                                          onPressed: () {
                                            homeProvider.setSelectedAgeOption(
                                                'Younger');
                                            Navigator.pop(context);
                                          },
                                          icon: homeProvider
                                                      .selectedAgeOption ==
                                                  'Younger'
                                              ? const Icon(Icons
                                                  .radio_button_on_outlined)
                                              : const Icon(Icons
                                                  .radio_button_off_outlined),
                                        ),
                                        title: const Text('Age : Younger'),
                                        onTap: () {
                                          homeProvider
                                              .setSelectedAgeOption('Younger');
                                          Navigator.pop(context);
                                        },
                                        selected:
                                            homeProvider.selectedAgeOption ==
                                                'Younger',
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.filter_list_sharp,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "User Lists",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: homeProvider.stream,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            QuerySnapshot querySnapshot = snapshot.data!;
                            List<QueryDocumentSnapshot> document =
                                querySnapshot.docs;
                            List<Map> items =
                                document.map((e) => e.data() as Map).toList();

                            items = homeProvider.filterItems(items);
// LazyLoading For each 5 items
                            return PaginateFirestore(
                              itemsPerPage: 5,
                              initialLoader: const Center(
                                child: CircularProgressIndicator(),
                              ),
                              onEmpty: const Center(
                                child: Text("Empty"),
                              ),
                              onError: (e) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              bottomLoader: const Center(
                                child: CircularProgressIndicator(),
                              ),
                              query: FirebaseFirestore.instance
                                  .collection("Upload_Items"),
                              itemBuilderType: PaginateBuilderType.listView,
                              separator: const SizedBox(
                                height: 10,
                              ),
                              isLive: true,
                              itemBuilder: (context, documentSnapshot, index) {
                                Map thisItems = items[index];
                                return Container(
                                  height: 80,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(blurRadius: .2)
                                      ],
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, left: 15),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 30,
                                                    backgroundImage: thisItems
                                                            .containsKey(
                                                                'image')
                                                        ? NetworkImage(
                                                            "${thisItems['image']}")
                                                        : null,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${thisItems['name']}",
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Text(
                                                          "Age : ${thisItems['age']}",
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          homeProvider
                                              .deleteUser(thisItems['name']);
                                        },
                                      ),
                                    ],
                                  ),
                                );

                                // itemCount: items.length,
                              },
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: Colors.black,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertBoxWidget();
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
