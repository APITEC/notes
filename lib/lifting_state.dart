import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  // Lista de objetos que usaremos para poblar nuestra ListView.
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List items = [
    {
      'name': 'Camera',
      'description': 'Nikkon P50-2',
      'icon': Icons.camera,
      'equipped': true
    },
    {
      'name': 'Phone',
      'description': 'Samsung Galaxy',
      'icon': Icons.phone_iphone,
      'equipped': false
    },
    {
      'name': 'Watch',
      'description': 'FitBit Charge',
      'icon': Icons.watch,
      'equipped': true
    },
    {
      'name': 'Computer',
      'description': 'MacBook Pro',
      'icon': Icons.computer,
      'equipped': true
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Backpack: ${items.where((element) => element['active'] == true).length}'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, item) {
          // Por cada elemento en nuestra lista 'items' retornamos una instancia de nuestro widget 'Item', pasandole los valores del elemento siendo recorrido como parámetros. Es aquí donde le pasamos información de un widget 'padre' (en este caso 'Home') a un hijo ('Item').
          return Item(
            name: items[item]['name'],
            description: items[item]['description'],
            icon: items[item]['icon'],
            equipped: items[item]['equipped'],
            callback: () {
              setState(() {
                items[item]['equipped'] = !items[item]['equipped'];
              });
            },
          );
        },
      ),
    );
  }
}

// Definimos un widget que reciclaremos en nuestro ListView.
class Item extends StatelessWidget {
  // Definimos variables dónde guardaremos los valores de los parámetros que se usarán para construirlo.
  final name;
  final description;
  final icon;
  final equipped;
  final callback;

  // Creamos un constructor que se encargará de guardar los parámetros proporcionados en las variables indicadas.
  Item({this.name, this.description, this.icon, this.equipped, this.callback});

  @override
  Widget build(BuildContext context) {
    // Usamos las variables definidas para extraer los valores necesarios.
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      subtitle: Text(description),
      trailing: ToggleStatus(equipped: equipped, callback: callback),
    );
  }
}

// Creamos un widget más para hacer el ejemplo más complejo. Lo mismo sucede aquí que en 'Item'.
class ToggleStatus extends StatelessWidget {
  final equipped;
  final callback;

  ToggleStatus({this.equipped, this.callback});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: callback,
      child: Icon(equipped ? Icons.check_box : Icons.check_box_outline_blank),
    );
  }
}
