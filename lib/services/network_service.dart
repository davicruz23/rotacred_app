import 'package:connectivity_plus/connectivity_plus.dart';
import 'sync_service.dart';

class NetworkService {
  final Connectivity _connectivity = Connectivity();

  void startListening() async {
    final result = await _connectivity.checkConnectivity();

    if (result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.mobile)) {
      print("🌐 Internet já disponível, iniciando sincronização...");
      SyncService().syncAll();
    }

    _connectivity.onConnectivityChanged.listen((result) {
      if (result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.mobile)) {
        print("🌐 Internet detectada, iniciando sincronização...");
        SyncService().syncAll();
      }
    });
  }
}
