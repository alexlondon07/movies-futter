import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/src/pages/models/peliculas_model.dart';
class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardSwiper({ @required this.peliculas});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return  Container(
        padding:  EdgeInsets.only(top: 10.0),
        child: Swiper(
            layout: SwiperLayout.STACK,
            itemWidth: _screenSize.width * 0.5,
            itemHeight: _screenSize.width * 0.7,
            itemBuilder: (BuildContext context, int index){
              return ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: FadeInImage(
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    image: NetworkImage( peliculas[index].getPosterImg()),
                    fit: BoxFit.cover,
                    )
              );
            },
            itemCount: peliculas.length
            /*    pagination: new SwiperPagination(),
            control: new SwiperControl(), */
          ),
      );
  }
}