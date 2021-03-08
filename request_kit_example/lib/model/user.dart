class User {
  String name;
  int age;

  User();

  User fromJson(Map<String, dynamic> json) {
    return User()
        ..name = json['name']
        ..age = json['age'];
  }

  @override
  String toString() {
    return '{name: $name, age: $age}';
  }
}

class School {
  String schoolName;
  String address;

  School();

  School fromJson(Map<String, dynamic> json) {
    return School()
      ..schoolName = json['schoolName']
      ..address = json['address'];
  }

  @override
  String toString() {
    return '{schoolName: $schoolName, address: $address}';
  }
}