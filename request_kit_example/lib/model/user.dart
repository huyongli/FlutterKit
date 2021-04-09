class User {
  final String name;
  final int age;

  User({required this.name, required this.age});


  User fromJson(Map<String, dynamic> json) {
    return User(name: json['name'], age: json['age']);
  }

  @override
  String toString() {
    return '{name: $name, age: $age}';
  }
}

class School {
  final String schoolName;
  final String address;

  School({required this.schoolName, required this.address});

  School fromJson(Map<String, dynamic> json) {
    return School(schoolName: json['schoolName'], address: json['address']);
  }

  @override
  String toString() {
    return '{schoolName: $schoolName, address: $address}';
  }
}