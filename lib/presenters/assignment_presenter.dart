import '../models/assignment_model.dart';

class AssignmentPresenter {
  final List<Assignment> _assignments = [];

  List<Assignment> get assignments => _assignments;

  void addAssignment(String title) {
    _assignments.add(Assignment(title: title));
  }

  void toggleCompleted(int index) {
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
