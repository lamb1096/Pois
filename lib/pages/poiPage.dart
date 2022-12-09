import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:pois/pages/poiListPage.dart';
import 'package:pois/pages/poiLocationPage.dart';

class PoiPage extends StatefulWidget {
  var poi;
  PoiPage({this.poi});

  @override
  State<PoiPage> createState() => _PoiPageState();
}

class _PoiPageState extends State<PoiPage> {
  var box;
  bool therIs = false;

  @override
  initState() {
    super.initState();

    load().then((value) {
      if (value != null) {
        therIs = true;
      }

      setState(() {});
    });
  }

  Future<dynamic> load() async {
    box = await Hive.openBox("pois");
    final poi = await box.get(widget.poi.reference.id);
    return poi;
  }

  @override
  Widget build(BuildContext context) {
    const image = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Icon(
          Icons.image,
          size: 200,
        ),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(children: [
        Text(
          widget.poi["nombre"],
          style: TextStyle(
              fontSize: 28.0,
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: therIs
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border),
          onPressed: () async {
            if (therIs) {
              box.delete(widget.poi.reference.id);
              setState(() {
                therIs = false;
              });
            } else {
              box.put(widget.poi.reference.id, {
                "nombre": widget.poi["nombre"],
                "puntuacion": widget.poi["puntuacion"].toString(),
                "descripcion": widget.poi["descripcion"],
                "lat": widget.poi["lat"],
                "long": widget.poi["long"]
              });
              setState(() {
                therIs = true;
              });
            }
          },
        )
      ]),
    );

    final fields = Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
        child: Column(
          children: [
            Text(widget.poi["puntuacion"].toString(),
                style: TextStyle(
                    fontSize: 16.0, color: Color.fromARGB(255, 122, 122, 122))),
          ],
        ));

    final lorem = Padding(
      padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
      child: Text(
        widget.poi["descripcion"],
        style: TextStyle(
            fontSize: 16.0, color: Color.fromARGB(255, 122, 122, 122)),
      ),
    );

    final map = Padding(
      padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 66, 66, 66),
        ),
        onPressed: () async {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PoiLocationPage(
                        lat: widget.poi["lat"],
                        long: widget.poi["long"],
                      )));
        },
        child: const Text('Ubicación', style: TextStyle(color: Colors.white)),
      ),
    );

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(28.0),
      child: Column(
        children: <Widget>[welcome, image, fields, lorem, map],
      ),
    );

    back() {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PoiListPage()));
    }

    return Scaffold(
        appBar: AppBar(
            title: Row(
              children: [
                IconButton(onPressed: back, icon: const Icon(Icons.arrow_back)),
                const Text("Detalle Sitio Turistico POI",
                    style: TextStyle(color: Colors.white))
              ],
            ),
            backgroundColor: const Color.fromARGB(255, 178, 178, 212)),
        body: body);
  }
}
