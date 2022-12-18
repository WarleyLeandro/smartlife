class Meal {
  late final String name;
  late final String description;
  late final String calories;
  late final String time;

  Meal(
      {required this.description,
      required this.name,
      required this.calories,
      required this.time});

  factory Meal.fromRTDB(data) {
    return Meal(
        description: data['description'],
        name: data['name'],
        calories: data['calories'],
        time: data['time']);
  }

  String MealDisplayText() {
    return 'Refeição: $name $description $calories $time';
  }
}
