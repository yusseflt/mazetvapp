abstract class PersistentObject {
  String id;
  String store;

  PersistentObject(String storeName) {
    store = storeName;
  }

  Map<String, dynamic> toJson();
}
