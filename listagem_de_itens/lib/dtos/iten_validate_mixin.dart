

import 'package:listagem_de_itens/exceptions/validate_exception.dart';

mixin class ItemValidate {
  void titleValidate(String title) {
    if (title.isEmpty) {
      throw 'O nome não pode ser vazio'.asException();
    }
  }

  void descricaoValidate(String descricao) {
    if (descricao.isEmpty) {
      throw 'Descrição não pode ser vazio'.asException();
    }
  }

  void imageValidate(String image) {
    if (image.isEmpty) {
      throw 'Imagem não pode ser vazio'.asException();
    }

    final regexp = RegExp(r'^https?://.*\.(?:png|jpg|jpeg)$');

    if (!regexp.hasMatch(image)) {
      throw 'Imagem inválida'.asException();
    }
  }
}
