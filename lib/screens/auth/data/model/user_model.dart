class UserModel {
    static const String collection = 'Users';
  UserModel({
     this.name,
     this.email,
     this.password,
     this.id,
  });
  String? name;
  String? email;
  String? password;
  String? id;

  UserModel.fromJson(Map<String, dynamic> json)
    : this(
        name: json['name'],
        email: json['email'],
        password: json['password'],
        id: json['id'],
      );

      Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'id': id,
      };
}
