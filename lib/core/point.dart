class Point {
  late int x;
  late int y;

  Point(this.x, this.y);


  List<Point> get directions => [
    Point(0, -1),
    Point(0, 1),
    Point(-1, 0),
    Point(1, 0),
    Point(-1, -1),
    Point(-1, 1),
    Point(1, -1),
    Point(1, 1)
  ];
}