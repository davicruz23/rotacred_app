class CollectorDto {
  final int idCollector;

  CollectorDto({required this.idCollector});
  CollectorDto.withId(int id) : idCollector = id;


  factory CollectorDto.fromJson(Map<String, dynamic> json) => CollectorDto(
        idCollector: json['idCollector'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'idCollector': idCollector,
      };
}