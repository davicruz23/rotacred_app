class CepResponse {
  final String cep;
  final String logradouro;
  final String bairro;
  final String localidade;

  CepResponse({
    required this.cep,
    required this.logradouro,
    required this.bairro,
    required this.localidade
  });

  factory CepResponse.fromJson(Map<String, dynamic> json) {
    return CepResponse(
      cep: json['cep'],
      logradouro: json['logradouro'],
      bairro: json['bairro'],
      localidade: json['localidade']
    );
  }
}
