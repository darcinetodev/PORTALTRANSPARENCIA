final String idColumn = "idColumn";
final String cnpjColumn = "cnpjColumn";
final String nameColumn = "nameColumn";
final String idAndressColumn = "idAndressColumn";

class CondominiumsModel {
  int id;
  String cnpj;
  String name;
  int idAndress;

  CondominiumsModel.fromMap(Map map) {
    id = map[idColumn];
    cnpj = map[cnpjColumn];
    name = map[nameColumn];
    idAndress = map[idAndressColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      cnpjColumn: cnpj,
      nameColumn: name,
      idAndressColumn: idAndress
    };
    if(id != null){
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "CondominiumsModel(id: $id, cnpj: $cnpj, name: $name, idAndress: $idAndress)";
  }
}