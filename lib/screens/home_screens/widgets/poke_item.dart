import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/consts/consts_api.dart';
import 'package:pokemon/consts/consts_app.dart';

class PokeItem extends StatelessWidget {
  final String name;
  final int index;
  final Color color;
  final String num;
  final List<String> types;

  const PokeItem({
    this.name,
    this.index,
    this.color,
    this.num,
    this.types,
  });

  Widget setTipos() {
    List<Widget> lista = [];
    types.forEach((nome) {
      lista.add(
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(80, 255, 255, 255)),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  nome.trim(),
                  style: TextStyle(
                      fontFamily: 'Google',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      );
    });
    return Column(
      children: lista,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Stack(
              //alignment: Alignment.bottomRight,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                      child: Text(
                        name,
                        style: TextStyle(
                            fontFamily: 'Google',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: setTipos(),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Opacity(
                    opacity: 0.2,
                    child: Image.asset(
                      ConstsApp.whitePokeball,
                      height: 80,
                      width: 80,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CachedNetworkImage(
                      height: 80,
                      width: 80,
                      imageUrl:
                          'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$num.png'),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: ConstsAPI.getColorType(type: types[0]),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
