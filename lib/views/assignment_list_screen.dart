import 'package:flutter/material.dart';

import '../presenters/assignment_presenter.dart';
import '../presenters/course_presenter.dart';
import '../widgets/add_fab.dart';

class AssignmentListScreen extends StatefulWidget {
  const AssignmentListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AssignmentListScreenState();
}

class _AssignmentListScreenState extends State<AssignmentListScreen> {
  final AssignmentPresenter _assignmentPresenter = AssignmentPresenter();
  final CoursePresenter _coursePresenter = CoursePresenter();
  bool _isLoading = true;
  String? _selectedCourseFilter;
  String? _newAssignmentCourse;
  List<String> _courseNames = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _assignmentPresenter.loadAssignments();
    await _coursePresenter.loadCourses();
    setState(() {
      _isLoading = false;
      _courseNames = _coursePresenter.courses.map((c) => c.name).toList();
    });
  }

  void _showAddAssignmentDialog() {
    String newAssignmentTitle = "";
    _newAssignmentCourse = _courseNames.isNotEmpty ? _courseNames.first : null;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Assignment"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Enter assignment title",
                ),
                onChanged: (value) {
                  newAssignmentTitle = value;
                },
              ),
              const SizedBox(height: 12),
              DropdownButton<String>(
                value: _newAssignmentCourse,
                items: _courseNames.map((name) {
                  return DropdownMenuItem(value: name, child: Text(name));
                }).toList(),
                onChanged: (value) =>
                    setState(() => _newAssignmentCourse = value),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (newAssignmentTitle.trim().isNotEmpty &&
                    _newAssignmentCourse != null) {
                  await _assignmentPresenter.addAssignment(
                    newAssignmentTitle.trim(),
                    _newAssignmentCourse!,
                  );
                  setState(() {});
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _renameAssignment(int index) async {
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
              onPressed: () async {
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

  TextStyle _getStyle(bool isCompleted) {
    if (isCompleted) {
      return TextStyle(decoration: TextDecoration.lineThrough);
    }
    return TextStyle();
  }

  @override
  Widget build(BuildContext context) {
    final assignments = _assignmentPresenter.assignments;
    final displayedAssignments = _selectedCourseFilter == null
        ? assignments
        : assignments
              .where((a) => a.courseName == _selectedCourseFilter)
              .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Assignments"),
        actions: [
          if (_courseNames.isNotEmpty)
            DropdownButton<String>(
              hint: const Text(
                "Filter by course",
                style: TextStyle(color: Colors.white),
              ),
              dropdownColor: Colors.blue[100],
              value: _selectedCourseFilter,
              onChanged: (value) {
                setState(() {
                  _selectedCourseFilter = value;
                });
              },
              items: [
                const DropdownMenuItem<String>(
                  value: null,
                  child: Text("All Courses"),
                ),
                ..._courseNames.map(
                  (name) => DropdownMenuItem(value: name, child: Text(name)),
                ),
              ],
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: displayedAssignments.length,
              itemBuilder: (context, index) {
                final assignment = displayedAssignments[index];
                return Card(
                  color: Color.from(
                    alpha: 1.0,
                    red: 0.9,
                    green: 0.9,
                    blue: 1.0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0), //14.0
                    child: ListTile(
                      // this displays title of the assignment
                      // so this is probably where text formatting code goes???
                      title: Text(
                        _assignmentPresenter.getAssignment(index).title,
                        style: _getStyle(
                          _assignmentPresenter.getAssignment(index).isCompleted,
                        ),
                      ),
                      trailing: SizedBox(
                        width: 196,
                        child: Row(
                          spacing: 64,
                          children: [
                            Expanded(
                              child: Checkbox(
                                //title: Text(assignment.title),
                                //subtitle: Text(
                                //  "Course: ${assignment.courseName}",
                                //),
                                value: assignment.isCompleted,
                                onChanged: (_) async {
                                  await _assignmentPresenter.toggleCompleted(
                                    index,
                                  );
                                  setState(() {});
                                },
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                onPressed: () async {
                                  await _renameAssignment(index);
                                  setState(() {});
                                },
                                icon: Icon(Icons.edit),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                onPressed: () async {
                                  await _assignmentPresenter.removeAt(index);
                                  setState(() {});
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
      floatingActionButton: AddFab(onPressed: _showAddAssignmentDialog),
    );
  }
}
