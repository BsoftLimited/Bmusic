//import 'package:bubble_navigation_bar/bubble_navigation_bar.dart';
import 'package:flutter/material.dart';

class CompleteReorderableList extends StatefulWidget {
  const CompleteReorderableList({ super.key });

  @override
  State<CompleteReorderableList> createState() => _CompleteReorderableListState();
}

class _CompleteReorderableListState extends State<CompleteReorderableList> {
  final List<TodoItem> _items = [
    TodoItem(id: '1', title: 'Buy milk', completed: false),
    TodoItem(id: '2', title: 'Call mom', completed: true),
    TodoItem(id: '3', title: 'Finish project', completed: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReorderableListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          return Card(
            key: Key(item.id),
            elevation: 2,
            child: ListTile(
              leading: ReorderableDragStartListener(
                index: index,
                child: Icon(Icons.drag_handle),
              ),
              title: Text(item.title),
              trailing: Checkbox(
                value: item.completed,
                onChanged: (value) {
                  setState(() {
                    item.completed = value ?? false;
                  });
                },
              ),
            ),
          );
        },
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final TodoItem item = _items.removeAt(oldIndex);
            _items.insert(newIndex, item);
          });
        },
        proxyDecorator: (child, index, animation) {
          return Material(
            elevation: 8,
            child: child,
          );
        },
      ),
    );
  }
}

class TodoItem {
  final String id;
  final String title;
  bool completed;

  TodoItem({
    required this.id,
    required this.title,
    required this.completed,
  });
}