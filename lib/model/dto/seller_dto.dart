class SellerDTO {
  final int idSeller;
  final String nomeSeller;

  SellerDTO({required this.idSeller, required this.nomeSeller});
  SellerDTO.withId(int id) : idSeller = id, nomeSeller = '';
  SellerDTO.withName(String name) : idSeller = 0, nomeSeller = name;

  factory SellerDTO.fromJson(Map<String, dynamic> json) => SellerDTO(
        idSeller: json['idSeller'] ?? 0,
        nomeSeller: json['nomeSeller'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'idSeller': idSeller,
        'nomeSeller': nomeSeller,
      };
}
