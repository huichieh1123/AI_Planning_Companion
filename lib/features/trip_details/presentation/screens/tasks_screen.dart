import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_planning_companion/core/theme/app_colors.dart';
import '../providers/tasks_provider.dart';
import '../../domain/models/task_model.dart';

class TasksScreen extends StatefulWidget {
  final String tripId;
  const TasksScreen({super.key, required this.tripId});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  int _selectedTabIndex = 0; // 0: 待分配, 1: 進度追蹤

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TasksProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildTeamMembersSection(provider),
                _buildTabSwitch(),
                Expanded(
                  child: _selectedTabIndex == 0 ? _buildUnassignedList(provider) : _buildProgressList(provider),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildTeamMembersSection(TasksProvider provider) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('團隊成員 (拖曳任務至頭像分配)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text('長按頭像查看任務', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ...provider.teamMembers.map((member) => Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: DragTarget<TaskModel>(
                      onAcceptWithDetails: (details) {
                        provider.assignTask(details.data, member.name);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('已將「\${details.data.title}」分配給 \${member.name}'),
                            duration: const Duration(seconds: 2),
                            backgroundColor: AppColors.success,
                          ),
                        );
                      },
                      builder: (context, candidateData, rejectedData) {
                        final isDraggingOver = candidateData.isNotEmpty;
                        return Column(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              transform: isDraggingOver ? Matrix4.diagonal3Values(1.1, 1.1, 1) : Matrix4.identity(),
                              child: CircleAvatar(
                                radius: 24,
                                backgroundColor: member.color.withValues(alpha: isDraggingOver ? 0.5 : 0.2),
                                child: Text(member.name[0], style: TextStyle(color: member.color, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(member.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            Text(member.role, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                          ],
                        );
                      },
                    ),
                  )),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.border, style: BorderStyle.solid),
                ),
                child: const Icon(Icons.add, color: AppColors.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabSwitch() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTabIndex = 0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedTabIndex == 0 ? AppColors.textPrimary : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Text(
                  '待分配',
                  style: TextStyle(
                    color: _selectedTabIndex == 0 ? Colors.white : AppColors.textSecondary,
                    fontWeight: _selectedTabIndex == 0 ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTabIndex = 1),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedTabIndex == 1 ? AppColors.textPrimary : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Text(
                  '進度追蹤',
                  style: TextStyle(
                    color: _selectedTabIndex == 1 ? Colors.white : AppColors.textSecondary,
                    fontWeight: _selectedTabIndex == 1 ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeleteBackground() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(Icons.delete_outline, color: Colors.white),
          Icon(Icons.delete_outline, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildUnassignedList(TasksProvider provider) {
    final tasks = provider.unassignedTasks;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: tasks.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('待分配清單', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              provider.isAiLoading
                  ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
                  : TextButton.icon(
                      onPressed: () => provider.autoAssignWithAi(),
                      icon: const Icon(Icons.auto_awesome, size: 16, color: AppColors.primary),
                      label: const Text('AI 智能分工', style: TextStyle(color: AppColors.primary)),
                    ),
            ],
          );
        }
        if (index == 1) return const SizedBox(height: 8);

        final task = tasks[index - 2];
        return Dismissible(
          key: Key(task.id),
          background: _buildDeleteBackground(),
          onDismissed: (_) {
            provider.deleteTask(task, isAssigned: false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('已刪除任務：\${task.title}'), duration: const Duration(seconds: 2)),
            );
          },
          child: LongPressDraggable<TaskModel>(
            data: task,
            feedback: Material(
              color: Colors.transparent,
              child: Opacity(
                opacity: 0.9,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 32,
                  child: _buildUnassignedCard(task.title, task.subtitle),
                ),
              ),
            ),
            childWhenDragging: Opacity(
              opacity: 0.3,
              child: _buildUnassignedCard(task.title, task.subtitle),
            ),
            child: _buildUnassignedCard(task.title, task.subtitle),
          ),
        );
      },
    );
  }

  Widget _buildProgressList(TasksProvider provider) {
    final tasks = provider.assignedTasks;
    int completedCount = tasks.where((t) => t.isCompleted).length;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: tasks.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('今日待辦任務 11/24 (週五)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('$completedCount/${tasks.length} 完成', style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          );
        }
        if (index == 1) return const SizedBox(height: 16);

        final task = tasks[index - 2];
        return Dismissible(
          key: Key(task.id),
          background: _buildDeleteBackground(),
          onDismissed: (_) {
            provider.deleteTask(task, isAssigned: true);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('已刪除任務：\${task.title}'), duration: const Duration(seconds: 2)),
            );
          },
          child: _buildTaskCard(provider, task),
        );
      },
    );
  }

  Widget _buildUnassignedCard(String title, String? subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(Icons.drag_indicator, color: AppColors.border),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ],
            ),
          ),
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(TasksProvider provider, TaskModel task) {
    return GestureDetector(
      onTap: () => provider.toggleTaskStatus(task),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(
              task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
              color: task.isCompleted ? AppColors.success : AppColors.border,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                          color: task.isCompleted ? AppColors.textSecondary : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('# AI 安排', style: TextStyle(fontSize: 10, color: Colors.purpleAccent, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.grey.withValues(alpha: 0.2),
                        child: Text(task.assignee?[0] ?? '?', style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 4),
                      Text(task.assignee ?? '未分配', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
