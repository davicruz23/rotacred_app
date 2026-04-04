class SellerIdUserDTO {
  final int idSeller;

  SellerIdUserDTO({required this.idSeller});

  factory SellerIdUserDTO.fromJson(Map<String, dynamic> json) {
    return SellerIdUserDTO(
      idSeller: json['idSeller'] ?? 0,
    );
  }
}
