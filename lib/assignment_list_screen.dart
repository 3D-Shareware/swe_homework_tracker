import 'package:flutter/material.dart';

class AssignmentListScreen extends StatefulWidget {
  const AssignmentListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AssignmentListScreenState();
}

class _AssignmentListScreenState extends State<AssignmentListScreen> {
  final List<Map<String, dynamic>> _assignments = [];

  void _showAddAssignmentDialog() {
    String newAssignmentTitle = "";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Assignment"),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: "Enter assignment title",
            ),
            onChanged: (value) {
              newAssignmentTitle = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (newAssignmentTitle.trim().isNotEmpty) {
                  setState(() {
                    _assignments.add({"title": newAssignmentTitle.trim()});
                  });
                }
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _toggleCompleted(int index, bool? value) {
    setState(() {
      _assignments[index]["completed"] = value ?? false;
    });
  }

  void _removeAssignment(int index) {
    setState(() {
      _assignments.removeAt(index);
    });
  }

  void _renameAssignment(int index) {
    String newAssignmentTitle = "";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Rename Assignment"),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: "Enter assignment title",
            ),
            onChanged: (value) {
              newAssignmentTitle = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (newAssignmentTitle.trim().isNotEmpty) {
                  setState(() {
                    _assignments[index]["title"] = newAssignmentTitle.trim();
                  });
                }
                Navigator.pop(context);
              },
              child: const Text("Rename"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Assignments")),
      body: ListView.builder(
        itemCount: _assignments.length,
        itemBuilder: (context, index) {
          return Card(
            color: Color.from(alpha: 1.0, red: 0.9, green: 0.9, blue: 1.0),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: ListTile(
                title: Text(_assignments[index]["title"]),
                trailing: SizedBox(
                  width: 196,
                  child: Row(
                    spacing: 64,
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          value: _assignments[index]["completed"] ?? false,
                          onChanged: (value) => _toggleCompleted(index, value),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            _renameAssignment(index);
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            _removeAssignment(index);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAssignmentDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
