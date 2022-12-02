import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pois/pages/poiPage.dart';

class PoiListPage extends StatefulWidget {
  const PoiListPage({super.key});

  @override
  State<PoiListPage> createState() => _PoiListPageState();
}

class _PoiListPageState extends State<PoiListPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: db.collection("pois").get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                    title: const Text("Sitios turisticos",
                        style: TextStyle(color: Colors.white)),
                    backgroundColor: const Color.fromARGB(255, 178, 178, 212)),
                body: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text(snapshot.data!.docs[index]["nombre"]),
                        leading: SizedBox(
                          width: 50,
                          height: 50,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PoiPage(
                                      poi: snapshot.data!.docs[index])));
                        },
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ));
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
