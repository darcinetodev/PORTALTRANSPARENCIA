final String idColumn = "idColumn";
final String idPeopleColumn = "idPeopleColumn";
final String idCondominiumColumn = "idCondominiumColumn";
final String titleColumn = "titleColumn";
final String descriptionColumn = "descriptionColumn";
final String textColumn = "textColumn";
final String imgColumn = "imgColumn";

class ClaimsModel {
  int id;
  String idPeople;
  String idCondominium;
  String title;
  String description;
  String text;
  String img;

  ClaimsModel.fromMap(Map map) {
    id = map[idColumn];
    idPeople = map[idPeopleColumn];
    idCondominium = map[idCondominiumColumn];
    title = map[titleColumn];
    description = map[descriptionColumn];
    text = map[textColumn];
    img = map[imgColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      idPeopleColumn: idPeople,
      idCondominiumColumn: idCondominium,
      titleColumn: title,
      descriptionColumn: description,
      textColumn: text,
      imgColumn: img
    };
    if(id != null){
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "ClaimsModel(id: $id, idPeople: $idPeople, idCondominium: $idCondominium, title: $title, description: $description, text: $text, img: $img)";
  }
}