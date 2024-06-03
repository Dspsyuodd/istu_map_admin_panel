enum BuildingObjectType {
  node._("Простая точка"),
  auditorium._("Аудитория"),
  cabinet._("Кабинет"),
  toilet._("Туалет"),
  cafe._("Кафе"),
  ladder._("Лестница"),
  elevator._("Лифт"),
  entrance._("Вход"),
  cashRegister._('Касса'),
  showplace._('Достопримечаетльность');

  final String name;

  const BuildingObjectType._(this.name);
}