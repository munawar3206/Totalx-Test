
import 'package:flutter/material.dart';

class AlertBoxWidget extends StatelessWidget {
  const AlertBoxWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add a new user",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: CircleAvatar(
              radius: 35,
              backgroundImage:
                  AssetImage("assets/log-removebg-preview.png"),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Name : ",
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 15),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Enter name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15), // Adjust padding here
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Name : ",
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 15),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Enter Age",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15), // Adjust padding here
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        const Color.fromARGB(255, 206, 206, 206)),
                child: MaterialButton(
                  onPressed: () {},
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: const Color.fromARGB(
                            255, 101, 101, 101)),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 49, 73, 255)),
                child: MaterialButton(
                  onPressed: () {},
                  child: Text(
                    "Save",
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255)),
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
