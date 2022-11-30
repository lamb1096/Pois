import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PoiPage extends StatefulWidget {
  const PoiPage({super.key});

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
          size: 250,
        ),
      ),
    );

    const welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Nombre POI',
        style: TextStyle(
            fontSize: 28.0,
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold),
      ),
    );

    final fields = Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
        child: Column(
          children: const [
            Text("Ciudad: XXXXXXX",
                style: TextStyle(
                    fontSize: 16.0, color: Color.fromARGB(255, 122, 122, 122))),
            Text("Departamento: XXXXXXX",
                style: TextStyle(
                    fontSize: 16.0, color: Color.fromARGB(255, 122, 122, 122))),
            Text("Temperatura: XX",
                style: TextStyle(
                    fontSize: 16.0, color: Color.fromARGB(255, 122, 122, 122))),
          ],
        ));

    const lorem = Padding(
      padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
      child: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec hendrerit condimentum mauris id tempor. Praesent eu commodo lacus. Praesent eget mi sed libero eleifend tempor. Sed at fringilla ipsum. Duis malesuada feugiat urna vitae convallis. Aliquam eu libero arcu.',
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
