class User {
  final int id;
  final String name;
  final String lastname;
  final String phone_number;
  final String birthday;
  final String email;
  final String gender;
  final String image;
  final int truekoin;


  User({this.id, this.name, this.lastname, this.phone_number, this.birthday,
      this.email, this.gender, this.image, this.truekoin});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      lastname: json['lastname'],
      phone_number: json['phone_number'],
      birthday: json['birthday'],
      email: json['email'],
      gender: json['gender'],
      image: json['image'],
      truekoin: json['truekoin']
    );
  }
}