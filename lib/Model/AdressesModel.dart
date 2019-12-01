final String idColumn = "idColumn";
final String zipCodeColumn = "zipCodeColumn";
final String placeColumn = "placeColumn";
final String cityColumn = "cityColumn";
final String countryColumn = "countryColumn";
final String nationColumn = "nationColumn";

class AndressModel {
  int id;
  String zipCode;
  String place;
  String city;
  String country;
  String nation;

  AndressModel.fromMap(Map map) {
    id = map[idColumn];
    zipCode = map[zipCodeColumn];
    place = map[placeColumn];
    city = map[cityColumn];
    country = map[countryColumn];
    nation = map[nationColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      zipCodeColumn: zipCode,
      placeColumn: place,
      cityColumn: city,
      countryColumn: country,
      nationColumn: nation
    };
    if(id != null){
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "AndressModel(id: $id, zipCode: $zipCode, place: $place, city: $city, country: $country, nation: $nation)";
  }
}