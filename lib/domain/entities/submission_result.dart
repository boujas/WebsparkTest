import 'package:equatable/equatable.dart';

final class SubmissionResult extends Equatable {
  const SubmissionResult({required this.taskId, required this.isCorrect});

  final String taskId;
  final bool isCorrect;

  @override
  List<Object> get props => [taskId, isCorrect];
}