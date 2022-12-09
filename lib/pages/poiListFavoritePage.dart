import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:pois/pages/poiListPage.dart';
import 'package:pois/pages/poiPage.dart';

class PoiListFavoritePage extends StatefulWidget {
  const PoiListFavoritePage({super.key});

  @override
  State<PoiListFavoritePage> createState() => _PoiListFavoritePageState();
}

class _PoiListFavoritePageState extends State<PoiListFavoritePage> {
  var box;
  Iterable<dynamic> list = [];

  @override
  initState() {
    super.initState();

    load().then((value) {
      list = value;

      setState(() {});
    });
  }

  Future<Iterable<dynamic>> load() async {
    var box2 = await Hive.openBox("pois");

    list = box2.values;
    return list;
  }

  back() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PoiListPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(onPressed: back, icon: const Icon(Icons.arrow_back)),
              const Text("Mis favoritos", style: TextStyle(color: Colors.white))
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 178, 178, 212),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text(list.elementAt(index)["nombre"]),
                leading: SizedBox(
                  width: 50,
                  height: 50,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PoiPage(poi: list.elementAt(index))));
                },
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ));
  }
}
