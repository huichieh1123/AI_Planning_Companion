import 'package:flutter/material.dart';
import '../../domain/models/task_model.dart';
import '../../domain/models/team_member.dart';
import '../../data/repositories/task_repository.dart';

class TasksProvider extends ChangeNotifier {
  final TaskRepository _repository = TaskRepository();
  final String tripId;

  bool isLoading = false;
  bool isAiLoading = false;
  List<TaskModel> unassignedTasks = [];
  List<TaskModel> assignedTasks = [];

  final List<TeamMember> teamMembers = [
    TeamMember(name: 'Andy', role: '隊長', color: Colors.blue),
    TeamMember(name: 'Bob', role: '隊員', color: Colors.green),
    TeamMember(name: 'Cindy', role: '隊員', color: Colors.orange),
  ];

  TasksProvider({required this.tripId}) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    isLoading = true;
    notifyListeners();

    try {
      unassignedTasks = await _repository.getUnassignedTasks(tripId);
      assignedTasks = await _repository.getAssignedTasks(tripId);
    } catch (e) {
      debugPrint('Error loading tasks: \$e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> assignTask(TaskModel task, String assigneeName) async {
    // Optimistic UI update
    unassignedTasks.removeWhere((t) => t.id == task.id);
    assignedTasks.insert(0, task.copyWith(assignee: assigneeName));
    notifyListeners();

    try {
      await _repository.assignTask(task.id, assigneeName);
    } catch (e) {
      // Revert on error
      loadTasks(); 
    }
  }

  Future<void> toggleTaskStatus(TaskModel task) async {
    final index = assignedTasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      final newStatus = !task.isCompleted;
      assignedTasks[index] = task.copyWith(isCompleted: newStatus);
      notifyListeners();

      try {
        await _repository.updateTaskStatus(task.id, newStatus);
      } catch (e) {
        // Revert
        assignedTasks[index] = task;
        notifyListeners();
      }
    }
  }

  Future<void> deleteTask(TaskModel task, {required bool isAssigned}) async {
    if (isAssigned) {
      assignedTasks.removeWhere((t) => t.id == task.id);
    } else {
      unassignedTasks.removeWhere((t) => t.id == task.id);
    }
    notifyListeners();

    try {
      await _repository.deleteTask(task.id);
    } catch (e) {
      loadTasks(); // Revert
    }
  }

  Future<void> addTask(TaskModel task) async {
    // Optimistic UI update
    unassignedTasks.insert(0, task);
    notifyListeners();

    try {
      await _repository.addTask(task);
    } catch (e) {
      unassignedTasks.removeWhere((t) => t.id == task.id);
      notifyListeners();
    }
  }

  Future<void> autoAssignWithAi() async {
    if (unassignedTasks.isEmpty) return;

    isAiLoading = true;
    notifyListeners();

    try {
      final members = teamMembers.map((m) => m.name).toList();
      final aiAssigned = await _repository.autoAssignTasksWithAi(unassignedTasks, members);
      
      unassignedTasks.clear();
      assignedTasks.insertAll(0, aiAssigned);
    } catch (e) {
      debugPrint('Error during AI assignment: \$e');
    } finally {
      isAiLoading = false;
      notifyListeners();
    }
  }
}
