import 'dart:js';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Projects',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const CRUDEoperation());
  }
}

class CRUDEoperation extends StatefulWidget {
  const CRUDEoperation({super.key});

  @override
  State<CRUDEoperation> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CRUDEoperation> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController positionController = positionEditingController();
  final TextEditingController _searchController = TextEditingController();


  final CollectionReference myItems = 
      FirebaseFirestore.instance.collection("CRUDitems");
  Future<void> create() async {
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return const Dialog(name: "Create Operation"), condition: "Create", 
        onPressed: () {
          String name= nameController.text;
          String description= positionController.text;
          addItems(name, description);
          Navigator.pop(context);
        });
      }

    )
  }

//ADD

void addItems(String name, String description){
  myItems.add({
    'name': name,
    'description': position,
     return showDialog(
      context: context,
      builder: (BuildContext context){
        return const Dialog(name: "Update your data"), condition: "Update", 
        onPressed: () {
          String name= nameController.text;
          String description= positionController.text;
          addItems(name, description);
          Navigator.pop(context);
          await myItems.doc(documentSnapshot.id).update({
            'name': name,
            'description': position,
          });
          nameController.text='';
          positionCOntroller.text='';
          Navigator.pop(context);
        }
        );
      }
  });
}

//UPDATE

Future <void> update (DcoumentSnapshot documentSnapshot)async{
    nameController.text= documentSNapshot['name'];
    positionController.text= documentSnapshot['description'];
}
bool isSeacrhClick = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 222, 221, 221),
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 188, 219, 233),
            title: const Text("Projects")
        )
        body: StreamBuilder(
          stream: myItems.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if(streamSnapshot.hasData){
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index){
                final documentSnapshot documentSnapshot= 
                  streamSnapshot.data!.docs[index];
                return Material(
                    child: ListTile(title: Text(documentSnapshot['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      documentSnapshot['description'],
                    ),
                    ),
                  );
            })
          }
          return const Center();
        }
        )
        floatingActionButton: FLoatingActionButton(
          onPressed: create () {},
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )

        ),
    );
  }

//DELETE

Future<void> delete(String poroductID) async{
  await myItems.doc(productID).delete();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.red,
    duration: Duration(milliseconds: 500),
    content: Text("Delete Successfully")),
  );
}

//SEARCH BAR
String searchText= '';

void onSearchChange(String value){
  setState((){
    _searchController = value;
  });
}

  Dialog myDialogBox({required BuildContext contex, required String name, required String condition, required VoidCallback onPressed()}) => Dialog(
    shape: RoundRectangleBorder(myItemsborderRadius: BorderRadius.circular(20),
    ),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal:20),
      child:column(
        MainAxisSize: MainAxisSize.min,
        children[
          Row(
            children: [
              Container(),
            Text(
              "Create Operation",
              style: TextStyle(
                fintWeight: FontWeight.bold,
                fontSize: 18,
              )
              )
              IconButton(
                onPressed: ()=> _update(documentSnapshot),
               icon: icon(
                Icons.close,
               ),
               )
              IconButton(
                onPressed: () =>delete(documentSnapshot),
               icon: icon(
                Icons.delete,
               ),
               )
              ],)
          TextField(
            controller: nameController,

            decoration: InputDecoration(
              labetText: "Enter the name",
              hintText: 'eg . Project 1'
            ), 
          ),
          const TextField(
            controller:position,
            decoration: InputDecoration(
              labetText: "Enter the description,
              hintText: 'eg . appartments'
            ), 
          ),
          SizedBox(height: 10),

        ],
      ),
    ),
  ),
}

