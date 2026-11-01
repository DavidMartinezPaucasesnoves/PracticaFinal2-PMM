import 'package:flutter/material.dart';

class WidgetScreen extends StatefulWidget {
  const WidgetScreen({super.key});

  @override
  State<WidgetScreen> createState() => _WidgetScreenState();
}

class _WidgetScreenState extends State<WidgetScreen> {
  List<String> _items = ["Elemento 1", "Elemento 2", "Elemento 3", "Elemento 4", "Elemento 5"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Widget Showcase"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              const Text("1. ExpansionTitle (Desplegable)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              const SizedBox(height: 8),
              const ExpansionTile(title: Text("Pulsa para desplegar Info"),
              leading: Icon(Icons.info),
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Hola!"),
                )
              ],
            ),

            const SizedBox(height: 24),

            const Text("2. Dismissible (Deslizar para borrar)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),

            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];

                  return Dismissible(
                    key: Key(item),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20),
                      child: const Icon(Icons.delete_forever, color: Colors.white), 
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        _items.removeAt(index);
                      });
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(item),
                        subtitle: const Text("Desliza a la derecha para Borrar"),
                      ),
                    ),
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}