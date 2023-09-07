class LoginModel
{
  String email;
  String password;

  LoginModel({
    required this.email,
    required this.password,
});
}

class RegisterModel
{
  String name;
  String email;
  String password;
  String phone;

  RegisterModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });
}

class UpdateUserDataModel
{
  String token;
  String name;
  String email;
  String phone;

  UpdateUserDataModel({
    required this.token,
    required this.name,
    required this.email,
    required this.phone,
});

}