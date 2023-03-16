import 'package:flutter/material.dart';

class MaterialEntry extends StatefulWidget {
  String materialName;
  int materialQuantity;
  bool isCollected;
  void Function(int) onDelete;
  int itemIndex;

  MaterialEntry({
    super.key,
    required this.materialName,
    required this.materialQuantity,
    required this.isCollected,
    required this.onDelete,
    required this.itemIndex,
  });

  @override
  _MaterialEntryState createState() => _MaterialEntryState();
}

class _MaterialEntryState extends State<MaterialEntry> {
  @override
  void initState() {
    super.initState();
  }

  void _incrementQuantity() {
    setState(() {
      widget.materialQuantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      widget.materialQuantity--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        key: widget.key,
        surfaceTintColor: widget.isCollected
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : Theme.of(context).colorScheme.primaryContainer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Row(children: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => widget.onDelete(widget.itemIndex),
                ),
                RichText(
                    text: TextSpan(
                        text: widget.materialName,
                        style: TextStyle(
                          decoration: widget.isCollected
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ))),
              ]),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: _decrementQuantity),
                Text(widget.materialQuantity.toString()),
                IconButton(
                    icon: const Icon(Icons.add), onPressed: _incrementQuantity),
                Checkbox(
                    value: widget.isCollected,
                    onChanged: (bool? value) {
                      setState(() {
                        widget.isCollected = value!;
                      });
                    })
              ],
            )
          ],
        ));
  }
}
