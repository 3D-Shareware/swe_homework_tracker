import '../models/assignment_model.dart';

class AssignmentPresenter {
  final List<Assignment> _assignments = [];

  List<Assignment> get assignments => _assignments;

  Future<void> loadAssignments() async {
    final fetched = await Assignment.fetchAssignments();
    _assignments
      ..clear()
      ..addAll(fetched);
  }

  Future<void> addAssignment(String title, String courseName) async {
    await Assignment.addAssignment(title, courseName);
    _assignments.add(Assignment(title: title, courseName: courseName));
  }

  Future<void> toggleCompleted(int index) async {
    await Assignment.updateCompletionStatus(index, _assignments);
    _assignments[index].isCompleted = !_assignments[index].isCompleted;
  }

  // feel like this is probably neccessary
  Assignment getAssignment(int index) {
    return _assignments[index];
  }

  // new renaming functionality! had to be written for the real-time database
  Future<void> renameAssignment(int index, String title) async {
    await Assignment.renameAssignment(index, title, _assignments);
    // hopefully reloading assignments immediately will fix the weird temporary de-sync after renaming an assignment
    // loadAssignments();
    _assignments[index].title = title;
  }

  int getNumberOfAssignments() {
    return _assignments.length;
  }

  // new deleting functionality! had to also be re-written for the real-time database
  Future<void> removeAt(int index) async {
    await Assignment.removeAssignment(index, _assignments);
    _assignments.removeAt(index);
  }
}
