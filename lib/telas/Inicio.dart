import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:youtube/model/Video.dart';
import '../Api.dart';


// classe okay

class Inicio extends StatefulWidget {

  String pesquisa;
  Inicio(this.pesquisa);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  _listarVideos(String pesquisa){ // metodo que chama lista de videos

    Api api = Api();    // classe API
    return api.pesquisar(pesquisa);

  }

  @override
  void initState() {
    super.initState();
    print("chamado 1 - initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("chamado 2 - didChangeDependencies");
  }

  @override
  void didUpdateWidget(Inicio oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("chamado 2 - didUpdateWidget");
  }

  @override
  void dispose() {
    super.dispose();
    print("chamado 4 - dispose");
  }

  @override
  Widget build(BuildContext context) {

    print("chamado 3 - build");

    return FutureBuilder<List<Video>>(
      future: _listarVideos( widget.pesquisa),
      builder: (contex, snapshot){
        switch( snapshot.connectionState ){
          case ConnectionState.none :  // conexão nula
          case ConnectionState.waiting : // conexão carregando
            return Center(
              child: CircularProgressIndicator(), // progressBar
            );
            break;
          case ConnectionState.active : // conexão ativa
          case ConnectionState.done :  // conexão okay
            if( snapshot.hasData ){

              return ListView.separated( // separador de itens da lista
                  itemBuilder: (context, index){

                    List<Video> videos = snapshot.data;
                    Video video = videos[ index ];

                    return GestureDetector( // detecta o click inicia o video
                      onTap: (){
                        FlutterYoutube.playYoutubeVideoById(
                            apiKey: CHAVE_YOUTUBE_API,
                            videoId: video.id,
                            autoPlay: true,
                            fullScreen: true
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage( video.imagem ),
                                )
                            ),
                          ),
                          ListTile(
                            title: Text( video.titulo ),
                            subtitle: Text( video.canal ),
                          )
                        ],
                      ),
                    );

                  },
                  separatorBuilder: (context, index) => Divider(
                    height: 2,
                    color: Colors.grey,
                  ),
                  itemCount: snapshot.data.length
              );
            }else{ // caso tenha algum erro
              return Center(
                child: Text("Nenhum dado a ser exibido!"),
              );
            }
            break;
        }
      },
    );
  }
}
