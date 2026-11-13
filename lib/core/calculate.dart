import 'package:test_task/core/grid.dart';
import 'package:test_task/core/point.dart';

class Calculate {

  List<Point>? findShortestPath(Grid _grid, Point start, Point end) {

    bool canStart = _grid.checkCanStart(start, end);

    if (canStart == false) return null;

    List<Point> queue = [];
    queue.add(start);

    Map<String, Point> cameFrom = {};
    List<String> visited = [];

    String startKey = "${start.x},${start.y}";
    String endKey = "${end.x},${end.y}";

    visited.add(startKey);

    bool found = false;

    while (queue.isNotEmpty) {
      Point current = queue.removeAt(0);
      if (current.x == end.x && current.y == end.y) {
        found = true;
        break;
      }

      for (int i = 0; i < current.directions.length; i++) {
        var dir = current.directions[i];

        int nextX = current.x + dir.x;
        int nextY = current.y + dir.y;
        String nextKey = "$nextX,$nextY";
        bool inBounds = nextX >= 0 && nextX < _grid.cols && nextY >= 0 && nextY < _grid.rows;

        if (inBounds) {
          bool isNotObstacle = _grid.grid[nextY][nextX].toLowerCase() != 'x';
          bool isNotVisited = !visited.contains(nextKey);

          if (isNotObstacle && isNotVisited) {
            visited.add(nextKey);
            queue.add(Point(nextX, nextY));
            cameFrom[nextKey] = current;
          }
        }
      }
    }
    if (found == false) {
      return null;
    }

    List<Point> path = [];
    String currentKey = endKey;
    Point? current = end;

    while (current != null) {
      path.insert(0, current);

      if (current.x == start.x && current.y == start.y) {
        break;
      }

      Point? previousPoint = cameFrom[currentKey];
      if (previousPoint == null) {
        break;
      }

      current = previousPoint;
      currentKey = "${current.x},${current.y}";
    }

    return path;
  }

  String convertToString(List list) {
    return list.map((p) => '(${p.x}.${p.y})').join('->');
  }

  List<Map<String, dynamic>> convertToSteps(List list) {
    return list.map((point) => {"x": point.x, "y": point.y}).toList();
  }
}