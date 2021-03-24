import 'package:http/http.dart' as http;
import 'dart:convert';


import 'model/Video.dart';

//classe okay

const CHAVE_YOUTUBE_API = "AIzaSyBrQSLDqhY4II3lRaYHkCEW5zfNOQtsGZc"; // API YOUTUBE
const ID_CANAL = "UCVHFbqXqoYvEWM1Ddxl0QDg"; // LINK DO CANAL
const URL_BASE = "https://www.googleapis.com/youtube/v3/"; // API GOOGLE

class Api {

  Future<List<Video>> pesquisar(String pesquisa) async { // metodo assicrono

    http.Response response = await http.get( // corpo do http
        URL_BASE + "search" // complemento API GOOGLE
            "?part=snippet"
            "&type=video" // tipo video
            "&maxResults=20" // maximo 20 resultados
            "&order=date" // ordenado por data
            "&key=$CHAVE_YOUTUBE_API" // chave API do youtube
            "&channelId=$ID_CANAL" // ID do canal a ser exibido na lista
            "&q=$pesquisa" // parametro passado na api
    );

    if( response.statusCode == 200 ){


      Map<String, dynamic> dadosJson = json.decode( response.body );
      // map percoree todas a lista
      List<Video> videos = dadosJson["items"].map<Video>(
              (map){
            return Video.fromJson(map);
            //return Video.converterJson(map);
          }
      ).toList();

      return videos;

      //print("Resultado: " + videos.toString() );

      /*
      for( var video in dadosJson["items"] ){
        print("Resultado: " + video.toString() );
      }*/
      //print("resultado: " + dadosJson["items"].toString() );

    }else{

    }

  }

}

