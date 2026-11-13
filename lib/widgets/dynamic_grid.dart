import 'package:flutter/material.dart';
import 'package:test_task/core/grid.dart';
import 'package:test_task/data/Params.dart';
import '../core/point.dart';

class DynamicGrid extends StatefulWidget {
  final Grid grid;
  final List<Point> path;

  const DynamicGrid(this.grid, this.path, {super.key});

  @override
  State<DynamicGrid> createState() => _DynamicGridState();
}

class _DynamicGridState extends State<DynamicGrid> {

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.grid.cols,
        childAspectRatio: 1.0
      ),
      itemCount: widget.grid.cols * widget.grid.rows,
      itemBuilder: (BuildContext context, int index) {
        int y = index ~/ widget.grid.cols;
        int x = index % widget.grid.cols;

        String cellValue = '($x,$y)';
        bool isStart = widget.path.first.x == x && widget.path.first.y == y;
        bool isEnd = widget.path.last.x == x && widget.path.last.y == y;
        bool isObs = widget.grid.grid[y][x].toLowerCase() == 'x';
        bool isPath = !isStart && !isEnd && widget.path.any((p) => p.x == x && p.y == y);

        Color color = Color(int.parse("FF${Params.defaultColor}", radix: 16));
        if (isObs) color = Color(int.parse("FF${Params.blockColor}", radix: 16));
        if (isPath) color = Color(int.parse("FF${Params.fillColor}", radix: 16));
        if (isStart) color = Color(int.parse("FF${Params.startColor}", radix: 16));
        if (isEnd) color = Color(int.parse("FF${Params.endColor}", radix: 16));

        Color textColor = isObs ? Colors.white : Colors.black;

        return Container(
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.black),
          ),
          child: Center(
            child: Text(
              cellValue,
              style: TextStyle(color: textColor, fontSize: 12),
            ),
          ),
        );
      },
    );
  }
}