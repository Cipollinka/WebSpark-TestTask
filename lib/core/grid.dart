import 'package:test_task/core/point.dart';

class Grid {

  Grid(this.grid);

  List<List<String>> grid = List.empty();

  int get rows => grid.length;
  int get cols => grid[0].length;

  bool checkCanStart(Point startPos, Point endPos) {
    return grid[startPos.x][startPos.y] != "X" && grid[endPos.x][endPos.y] != "X";
  }
}