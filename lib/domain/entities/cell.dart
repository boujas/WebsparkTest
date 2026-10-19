import 'package:equatable/equatable.dart';

final class Cell extends Equatable {
  const Cell(this.x, this.y);

  final int x;
  final int y;

  @override
  List<Object> get props => [x, y];

  @override
  String toString() => '($x,$y)';
}