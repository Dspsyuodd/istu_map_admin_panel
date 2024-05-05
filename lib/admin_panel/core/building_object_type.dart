enum BuildingObjectType {
  node._("Простая точка"),
  auditorium._("Аудитория"),
  cabinet._("Кабинет"),
  toilet._("Туалет"),
  cafe._("Кафе"),
  ladder._("Лестница"),
  elevator._("Лифт"),
  entrance._("Вход");

  final String name;

  const BuildingObjectType._(this.name);
}