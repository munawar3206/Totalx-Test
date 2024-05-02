import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:totalxtask/view/widget/alertbox.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    _stream = FirebaseFirestore.instance.collection("Upload_Items").snapshots();
    super.initState();
  }

  String selectedAgeOption = '';
  late Stream<QuerySnapshot> _stream;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 228, 228, 227),
        body: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search by name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.only(top: 10, left: 20),
                                  child: Text(
                                    "Sort",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  ),
                                ),
                                ListTile(
                                  leading: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedAgeOption = 'All';
                                      });
                                      Navigator.pop(context);
                                    },
                                    icon: selectedAgeOption == 'All'
                                        ? const Icon(
                                            Icons.radio_button_on_outlined)
                                        : const Icon(
                                            Icons.radio_button_off_outlined),
                                  ),
                                  title: const Text('All'),
                                  onTap: () {
                                    setState(() {
                                      selectedAgeOption = 'All';
                                    });
                                    Navigator.pop(context);
                                  },
                                  selected: selectedAgeOption == 'All',
                                ),
                                ListTile(
                                  leading: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedAgeOption = 'Elder';
                                      });
                                      Navigator.pop(context);
                                    },
                                    icon: selectedAgeOption == 'Elder'
                                        ? const Icon(
                                            Icons.radio_button_on_outlined)
                                        : const Icon(
                                            Icons.radio_button_off_outlined),
                                  ),
                                  title: const Text('Age : Elder'),
                                  onTap: () {
                                    setState(() {
                                      selectedAgeOption = 'Elder';
                                    });
                                    Navigator.pop(context);
                                  },
                                  selected: selectedAgeOption == 'Elder',
                                ),
                                ListTile(
                                  leading: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedAgeOption = 'Younger';
                                      });
                                      Navigator.pop(context);
                                    },
                                    icon: selectedAgeOption == 'Younger'
                                        ? const Icon(
                                            Icons.radio_button_on_outlined)
                                        : const Icon(
                                            Icons.radio_button_off_outlined),
                                  ),
                                  title: const Text('Age : Younger'),
                                  onTap: () {
                                    setState(() {
                                      selectedAgeOption = 'Younger';
                                    });
                                    Navigator.pop(context);
                                  },
                                  selected: selectedAgeOption == 'Younger',
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
                  stream: _stream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      QuerySnapshot querySnapshot = snapshot.data;
                      List<QueryDocumentSnapshot> document = querySnapshot.docs;
                      List<Map> items =
                          document.map((e) => e.data() as Map).toList();
                      return ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          Map thisItems = items[index];
                          return Container(
                            height: 80,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        child: thisItems.containsKey('image')
                                            ? ClipOval(
                                                child: Image.network(
                                                  "${thisItems['image']}",
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                            : const CircleAvatar(),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${thisItems['name']}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "${thisItems['age']}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
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
                return const AlertBoxWidget();
              },
            );
          },
        ),
      ),
    );
  }
}
