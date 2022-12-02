import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PoiPage extends StatefulWidget {
  var poi;
  PoiPage({this.poi});

  @override
  State<PoiPage> createState() => _PoiPageState();
}

class _PoiPageState extends State<PoiPage> {
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
      child: Text(
        widget.poi["nombre"],
        style: TextStyle(
            fontSize: 28.0,
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold),
      ),
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

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(28.0),
      child: Column(
        children: <Widget>[welcome, image, fields, lorem],
      ),
    );

    return Scaffold(
        appBar: AppBar(
            title: const Text("Detalle Sitio Turistico POI",
                style: TextStyle(color: Colors.white)),
            backgroundColor: const Color.fromARGB(255, 178, 178, 212)),
        body: body);
  }
}
