import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AlertBoxWidget extends StatefulWidget {
  const AlertBoxWidget({
    super.key,
  });

  @override
  State<AlertBoxWidget> createState() => _AlertBoxWidgetState();
}

class _AlertBoxWidgetState extends State<AlertBoxWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final CollectionReference _items =
      FirebaseFirestore.instance.collection("Upload_Items");
  String imageUrl = "";
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Add a new user",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Stack(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundImage:
                      AssetImage("assets/log-removebg-preview.png"),
                ),
                Positioned(
                  top: 42,
                  child: Transform.rotate(
                    angle: 3.14 / 1,
                    child: const ClipRect(
                      child: Align(
                        alignment: Alignment.topCenter,
                        heightFactor: 0.4,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Color.fromARGB(165, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 32,
                  left: 12,
                  child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            builder: (_) {
                              return ListView(
                                shrinkWrap: true,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text(
                                      "Pick Image From",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: const CircleBorder(),
                                              elevation: 20,
                                              backgroundColor:
                                                  Color.fromARGB(255, 0, 0, 0),
                                            ),
                                            onPressed: () async {
                                              // add imagepicker for gallery
                                              final file = await ImagePicker()
                                                  .pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              if (file == null) return;
                                              String fileName = DateTime.now()
                                                  .microsecondsSinceEpoch
                                                  .toString();

                                              // Get the reference to storage
                                              Reference referenceRoot =
                                                  FirebaseStorage.instance
                                                      .ref();
                                              Reference referenceDireImage =
                                                  referenceRoot.child('images');

                                              Reference referenceImageToUpload =
                                                  referenceDireImage
                                                      .child(fileName);

                                              try {
                                                await referenceImageToUpload
                                                    .putFile(File(file.path));
                                                imageUrl =
                                                    await referenceImageToUpload
                                                        .getDownloadURL();
                                              } catch (e) {}
                                            },
                                            child: Image.asset(
                                              "assets/gal;l.png",
                                              height: 30,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            "Gallery",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: const CircleBorder(),
                                              elevation: 20,
                                              backgroundColor:
                                                  Color.fromARGB(255, 0, 0, 0),
                                            ),
                                            onPressed: () async {
                                              final file = await ImagePicker()
                                                  .pickImage(
                                                      source:
                                                          ImageSource.camera);
                                              if (file == null) return;
                                            },
                                            child: Image.asset(
                                              "assets/camer-removebg-preview.png",
                                              height: 30,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            "Camera",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            });
                      },
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        size: 20,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Name : ",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: "Enter name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 15), // Adjust padding here
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Age : ",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: _ageController,
            decoration: InputDecoration(
              hintText: "Enter Age",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 15), // Adjust padding here
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 206, 206, 206)),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Color.fromARGB(255, 101, 101, 101)),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 49, 73, 255)),
                child: MaterialButton(
                  onPressed: () async {
                    if (imageUrl.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please select and Upload Image")));
                      return;
                    }
                    final String name = _nameController.text;
                    final int? age = int.tryParse(_ageController.text);
                    if (age != null) {
                      await _items
                          .add({"name": name, "age": age, "image": imageUrl});
                      _nameController.text = "";
                      _ageController.text = '';

                      // Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
