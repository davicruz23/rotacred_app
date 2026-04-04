class ProductSaleDTO {
  final int id;
  final String nameProduct;

  ProductSaleDTO({
    required this.id,
    required this.nameProduct,
  });

  factory ProductSaleDTO.fromJson(Map<String, dynamic> json) {
    return ProductSaleDTO(
      id: json['id'],
      nameProduct: json['nameProduct'],
    );
  }
}
