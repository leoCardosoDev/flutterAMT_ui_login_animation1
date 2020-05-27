import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginanimation1app/widgets/btn_animated.dart';
import 'package:loginanimation1app/widgets/custom_input.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  
  Color _colorPrimary = Color.fromRGBO(255, 100, 127, 1);
  
  AnimationController _animationController;
  Animation<double> _animationBlur;
  Animation<double> _animationFade;
  Animation<double> _animationSize;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this
    );
    
    _animationBlur = Tween<double>(
      begin: 5,
      end: 0
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease
    ));

    _animationFade = Tween<double>(
      begin: 0,
      end: 1
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutQuint
    ));

    _animationSize = Tween<double>(
      begin: 0,
      end: 500
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.decelerate
    ));
    
    _animationController.forward();
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    
    //timeDilation = 8;
    
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              AnimatedBuilder(
                animation: _animationBlur,
                builder: (context, widget){
                  return Container(
                    height: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/fundo.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: _animationBlur.value,
                        sigmaY: _animationBlur.value,
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 10,
                            child: FadeTransition(
                              opacity: _animationFade,
                              child: Image.asset('assets/detalhe1.png')),
                          ),
                          Positioned(
                            left: 50,
                            child: FadeTransition(
                              opacity: _animationFade,
                              child: Image.asset('assets/detalhe2.png')),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: <Widget>[
                    AnimatedBuilder(
                      animation: _animationSize,
                      builder: (context, widget){
                        return Container(
                          width: _animationSize.value,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[200],
                                blurRadius: 15,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              CustomInput(icon: Icon(Icons.person), hint: 'E-mail', obscure: false),
                              SizedBox(height: 6),
                              CustomInput(icon: Icon(Icons.lock), hint: 'Senha', obscure: true),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    BtnAnimated(_animationController),
                    SizedBox(height: 10),
                    FadeTransition(
                      opacity: _animationFade,
                      child: FlatButton(
                        onPressed: () {},
                        child: Text(
                          'Esqueci minha senha',
                          style: TextStyle(color: _colorPrimary, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
