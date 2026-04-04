import '../model/client.dart';
import '../database/entities/client_local.dart';
import '../database/entities/address_local.dart';

class ClientMapper {

  static ClientLocal toLocal(Client client) {

    final local = ClientLocal();

    local.serverId = client.id;
    local.name = client.name;
    local.cpf = client.cpf;
    local.phone = client.phone;

    local.address = AddressLocal()
      ..street = client.address.street
      ..number = client.address.number
      ..complement = client.address.complement
      ..city = client.address.city
      ..state = client.address.state
      ..zipCode = client.address.zipCode;

    return local;

  }

}