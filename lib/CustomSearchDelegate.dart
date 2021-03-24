import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<String>{
  @override
  List<Widget> buildActions(BuildContext context) { // defini as ações que usuario
    //pode utilizar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = ""; // "query" acesso a atributo que está sendo digitado
          // definir espçao vazio limpa o campo
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {  // define o voltar
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
        close(context, ""); // fecha a tela e retorna
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) { // tras os resultados
    close(context, query );
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) { // define todas as sugestoes
    return Container();
  }



}