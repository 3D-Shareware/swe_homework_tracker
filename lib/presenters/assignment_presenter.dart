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

  Future<void> addAssignment(String title) async {
    await Assignment.addAssignment(title);
    _assignments.add(Assignment(title: title));
  }

  Future<void> toggleCompleted(int index) async {
    await Assignment.updateCompletionStatus(index, _assignments);
    _assignments[index].isCompleted = !_assignments[index].isCompleted;
  }

  // feel like this is probably neccessary
  Assignment getAssignment(int index) {
    return _assignments[index];
  }

  void renameAssignment(int index, String title) {
    _assignments[index].title = title;
  }

  int getNumberOfAssignments() {
    return _assignments.length;
  }

  void removeAt(int index) {
    _assignments.removeAt(index);
  }
}
