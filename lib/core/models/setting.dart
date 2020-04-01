final String columnId = '_id';
final String columnKey = 'key';
final String columnValue = 'value';

class Setting {
  int id;
  String key;
  Object value;

  Setting(String key, Object value) {
    this.key = key;
    this.value = value;
  }

  // convenience constructor to create a Word object
  Setting.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    key = map[columnKey];
    value = map[columnValue];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{columnKey: key, columnValue: value};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}
