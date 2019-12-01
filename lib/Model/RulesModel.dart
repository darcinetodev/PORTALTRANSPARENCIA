final String idColumn = "idColumn";
final String idPeopleColumn = "idPeopleColumn";
final String idCondominiumColumn = "idCondominiumColumn";
final String textColumn = "textColumn";

class RulesModel {
  int id;
  String idPeople;
  String idCondominium;
  String text;

  RulesModel.fromMap(Map map) {
    id = map[idColumn];
    idPeople = map[idPeopleColumn];
    idCondominium = map[idCondominiumColumn];
    text = map[textColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      idPeopleColumn: idPeople,
      idCondominiumColumn: idCondominium,
      textColumn: text,
    };
    if(id != null){
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "RulesModel(id: $id, idPeople: $idPeople, idCondominium: $idCondominium, text: $text)";
  }
}