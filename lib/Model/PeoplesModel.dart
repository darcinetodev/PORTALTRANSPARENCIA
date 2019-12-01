final String idColumn = "idColumn";
final String idCondominiumColumn = "idCondominiumColumn";
final String cpfColumn = "cpfColumn";
final String nameColumn = "nameColumn";
final String birthdayColumn = "birthdayColumn";
final String emailColumn = "emailColumn";
final String passwordColumn = "passwordColumn";
final String imgProfileColumn = "imgProfileColumn";

class PeoplesModel {
  int id;
  int idCondominium;
  String cpf;
  String name;
  DateTime birthday;
  String email;
  String password;
  String imgProfile;

  PeoplesModel.fromMap(Map map) {
    id = map[idColumn];
    idCondominium = map[idCondominiumColumn];
    cpf = map[cpfColumn];
    name = map[nameColumn];
    birthday = map[birthdayColumn];
    email = map[emailColumn];
    password = map[passwordColumn];
    imgProfile = map[imgProfileColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      idCondominiumColumn: idCondominium,
      cpfColumn: cpf,
      nameColumn: name,
      birthdayColumn: birthday,
      emailColumn: email,
      passwordColumn: password,
      imgProfileColumn: imgProfile
    };
    if(id != null){
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "PeoplesModel(id: $id, idCondominium: $idCondominium, cpf: $cpf, name: $name, birthday: $birthday, email: $email, password: $password, imgProfile: $imgProfile)";
  }
}