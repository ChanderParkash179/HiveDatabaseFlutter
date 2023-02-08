import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hivedb/utils/Utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  var name = "NAME", age = '0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive Database System'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please Enter your Name',
                    prefixIcon: Icon(CupertinoIcons.profile_circled),
                    labelText: 'Name',
                  ),
                ),
                Utils().verticalSpace(20),
                TextFormField(
                  controller: ageController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please Enter your Age',
                    prefixIcon: Icon(CupertinoIcons.number_circle_fill),
                    labelText: 'Age',
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Name : $name',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Utils().verticalSpace(20),
          Text(
            'Age : $age',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Utils().verticalSpace(20),
          FutureBuilder(
              future: Hive.openBox('customers'),
              builder: (context, snapshot) {
                return ListTile(
                  title: Text(
                    snapshot.data!.get('name').toString(),
                  ),
                  subtitle: Text(
                    snapshot.data!.get('age').toString(),
                  ),
                );
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            name = nameController.text.toString();
            age = ageController.text.toString();

            databaseMethod(name, age);
          });
        },
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }
}

databaseMethod(var name, var age) async {
  var customers = await Hive.openBox('customers');

  customers.put('name', name);
  customers.put('age', age);

  return customers;
}
