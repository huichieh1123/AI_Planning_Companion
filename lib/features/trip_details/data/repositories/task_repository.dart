import '../../domain/models/task_model.dart';

class TaskRepository {
  // Simulate network delay for fetching unassigned tasks
  Future<List<TaskModel>> getUnassignedTasks(String tripId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      TaskModel(id: '1', title: '買共用零食跟飲料', subtitle: '出發前去全聯買齊'),
      TaskModel(id: '2', title: '預訂龜山島賞鯨船票', subtitle: '確認大家會不會暈船'),
      TaskModel(id: '3', title: '確認民宿入住時間', subtitle: '聯絡房東確認提早放行李'),
      TaskModel(id: '4', title: '查備用室內景點', subtitle: '若下雨需去蘭陽博物館'),
    ];
  }

  // Simulate network delay for fetching assigned tasks
  Future<List<TaskModel>> getAssignedTasks(String tripId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      TaskModel(id: '5', title: '預訂蘭城晶英烤鴨', assignee: 'Bob', isCompleted: false),
      TaskModel(id: '6', title: '租機車 (2台)', assignee: 'Bob', isCompleted: false),
      TaskModel(id: '7', title: '準備海灘野餐墊', assignee: 'Cindy', isCompleted: false),
      TaskModel(id: '8', title: '查備用室內景點', assignee: 'Andy', isCompleted: false),
      TaskModel(id: '9', title: '確認民宿入住時間', assignee: 'Bob', isCompleted: true),
    ];
  }

  // In the future, this will call the Node.js API to ask OpenAI to assign tasks
  Future<List<TaskModel>> autoAssignTasksWithAi(List<TaskModel> tasks, List<String> members) async {
    await Future.delayed(const Duration(seconds: 2));
    // Simulated AI response
    return tasks.map((t) => t.copyWith(assignee: members[tasks.indexOf(t) % members.length])).toList();
  }

  Future<void> assignTask(String taskId, String assignee) async {
    // Simulate API call to assign task
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<void> updateTaskStatus(String taskId, bool isCompleted) async {
    // Simulate API call to toggle completion
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<void> deleteTask(String taskId) async {
    // Simulate API call to delete
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
