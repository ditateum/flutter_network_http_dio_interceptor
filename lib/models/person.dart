class Person {
  final int id;
  final String name;
  final String email;

  Person({
    required this.id,
    required this.name,
    required this.email,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json["id"],
      name: json["first_name"] + " " + json["last_name"],
      email: json["email"],
    );
  }
}
