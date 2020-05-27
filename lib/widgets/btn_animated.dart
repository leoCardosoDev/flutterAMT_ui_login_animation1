import 'package:flutter/material.dart';

class BtnAnimated extends StatelessWidget {
 
 Color _colorPrimary = Color.fromRGBO(255, 100, 127, 1);
 Color _colorSecondary = Color.fromRGBO(255, 123, 145, 1);
 Animation<double> largura;
 Animation<double> opacidade;
 
 
 final AnimationController _animationController;
 BtnAnimated(this._animationController) : largura = Tween<double>(
  begin: 0,
  end: 500
 ).animate(CurvedAnimation(
  parent: _animationController,
  curve: Interval(0.5, 0.7),
 )),
 
 opacidade = Tween<double>(
 begin: 0,
 end: 500
 ).animate(CurvedAnimation(
 parent: _animationController,
 curve: Interval(0.6, 1),
 ))
 ;
 
 
 
 Widget _buildAnimation(BuildContext context, Widget widget){
  return InkWell(
   onTap: () {},
   child: Container(
    width: largura.value,
    height: 50,
    decoration: BoxDecoration(
     borderRadius: BorderRadius.circular(10),
     gradient: LinearGradient(
      colors: [
       _colorPrimary,
       _colorSecondary,
      ],
     ),
    ),
    child: Center(
     child: FadeTransition(
      opacity: opacidade,
       child: Text(
        'Entrar',
        style: TextStyle(
         color: Colors.white,
         fontSize: 20,
         fontWeight: FontWeight.bold,
        ),
       ),
     ),
    ),
   ),
  );
 }
 
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
     animation: largura,
     builder: (context, widget){
      return _buildAnimation(context, widget);
     },
    );
  }
}
