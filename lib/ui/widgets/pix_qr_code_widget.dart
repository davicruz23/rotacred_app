import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PixQrCodeWidget extends StatelessWidget {
  final String brCode;

  const PixQrCodeWidget({Key? key, required this.brCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Use QrImageView se QrImage der erro
        QrImageView(
          data: brCode,
          version: QrVersions.auto,
          size: 200,
        ),
        const SizedBox(height: 16),
        const Text(
          "Escaneie para pagar via PIX",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
