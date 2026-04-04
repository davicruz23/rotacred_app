class InspectorDTO {
  final int idInspector;

  InspectorDTO({required this.idInspector});
  InspectorDTO.withId(int id) : idInspector = id;


  factory InspectorDTO.fromJson(Map<String, dynamic> json) => InspectorDTO(
        idInspector: json['idInspector'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'idInspector': idInspector,
      };
}