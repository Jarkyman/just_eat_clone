class SignUpBody {
  String name;
  String phone;
  String email;
  String password;

  SignUpBody({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['f_name'] = this.name;
    json['phone'] = this.phone;
    json['email'] = this.email;
    json['password'] = this.password;
    return json;
  }

}
