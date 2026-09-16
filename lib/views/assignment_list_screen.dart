import 'package:flutter/material.dart';

import '../presenters/assignment_presenter.dart';

class AssignmentListScreen extends StatefulWidget {
  const AssignmentListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AssignmentListScreenState();
}

class _AssignmentListScreenState extends State<AssignmentListScreen> {
  final AssignmentPresenter _assignmentPresenter = AssignmentPresenter();

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
                    _assignmentPresenter.addAssignment(
                      newAssignmentTitle.trim(),
                    );
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
                    _assignmentPresenter.renameAssignment(
                      index,
                      newAssignmentTitle.trim(),
                    );
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
        itemCount: _assignmentPresenter.getNumberOfAssignments(),
        itemBuilder: (context, index) {
          return Card(
            color: Color.from(alpha: 1.0, red: 0.9, green: 0.9, blue: 1.0),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: ListTile(
                title: Text(_assignmentPresenter.getAssignment(index).title),
                trailing: SizedBox(
                  width: 196,
                  child: Row(
                    spacing: 64,
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          value: _assignmentPresenter
                              .getAssignment(index)
                              .isCompleted,
                          onChanged: (value) => setState(() {
                            // toggle assignment
                            _assignmentPresenter.toggleCompleted(index);
                          }),
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
                            setState(() {
                              // remove
                              _assignmentPresenter.removeAt(index);
                            });
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
