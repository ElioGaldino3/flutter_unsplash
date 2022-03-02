import 'package:flutter/material.dart';

import '../models/erros.dart';

class ErrWidget extends StatelessWidget {
  final Failure err;
  final VoidCallback? retry;

  const ErrWidget({
    Key? key,
    required this.err,
    this.retry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String errMessage = 'Erro desconhecido';
    if (err is UnauthorizedFailure) {
      errMessage = 'Você não tem autorização!';
    }
    if (err is ConnectionFailure) {
      errMessage = 'Erro de conexão, cheque sua conexão!';
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(errMessage),
        const SizedBox(height: 8),
        ElevatedButton(
            onPressed: retry,
            child: const Text('Tentar Novamente'))
      ],
    );
  }
}
