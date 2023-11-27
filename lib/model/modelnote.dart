class Note {
  final String id;
  final String title;
  final DateTime date;
  final String status;
  final String prioritas;
  final bool isDone;

  Note({
    required this.id,
    required this.title,
    required this.date,
    required this.status,
    required this.prioritas,
    required this.isDone,
  });
}