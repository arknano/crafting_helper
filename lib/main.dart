import 'package:flutter/material.dart';
import 'material_entry.dart';
import 'color_schemes.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '39C Crafting Helper',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      themeMode: ThemeMode.light,
      home: const MyHomePage(title: '39C Crafting Helper'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  final devMode = true;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> materials = [];
  final TextEditingController _textFieldController = TextEditingController();

  late String tempNewMaterialName;

  void _addMaterial(
      String materialName, int materialQuantity, bool isCollected) {
    setState(() {
      materials.add({
        'materialName': materialName,
        'materialQuantity': materialQuantity,
        'isCollected': isCollected,
      });
    });
  }

  void _removeMaterial(int index) {
    setState(() {
      materials.removeAt(index);
    });
  }

  Future<void> _displayMaterialNameEntryDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('New material name'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  tempNewMaterialName = value;
                });
              },
              controller: _textFieldController,
              decoration: const InputDecoration(
                  hintText: "e.g. Iron Bars, Skulls, etc"),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                child: const Text('Add new material'),
                onPressed: () {
                  setState(() {
                    _addMaterial(tempNewMaterialName, 0, false);
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: materials.length,
          itemBuilder: (context, index) {
            return MaterialEntry(
              materialName: materials[index]['materialName'],
              materialQuantity: materials[index]['materialQuantity'],
              isCollected: materials[index]['isCollected'],
              itemIndex: index,
              onDelete: (index) => _removeMaterial(index),
            );
          },
          padding: const EdgeInsets.symmetric(horizontal: 40),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayMaterialNameEntryDialog(context),
        tooltip: 'Add new material',
        child: const Icon(Icons.add),
      ),
    );
  }
}
