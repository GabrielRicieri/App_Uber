import 'package:flutter/material.dart';
import 'package:uber/model/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Cadastro  extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

TextEditingController _controllerNome = TextEditingController();
TextEditingController _controllerEmail = TextEditingController();
TextEditingController _controllerSenha = TextEditingController();
bool _tipoUsuario = false;
String _menssagemErro = "";

_validarCampos(){
//recuperar dados do campo
  String nome = _controllerNome.text;
  String email = _controllerEmail.text;
  String senha = _controllerSenha.text;

  //validar campos
    if(nome.isNotEmpty){
      if( email.isNotEmpty && email.contains("@")){
        if( senha.isNotEmpty && senha.length > 6){
            Usuario usuario = Usuario();
            usuario.nome = nome;
            usuario.email = email;
            usuario.senha = senha;
            usuario.tipoUsuario = usuario.verificaTipoUsuario(_tipoUsuario);

            _cadastrarUsuario( usuario)
        }else{
           setState(() {
        _menssagemErro = "Preencha a senha com mais de 6 characteres";
      });
        }

      }else{
        setState(() {
        _menssagemErro = "Preencha um email valido";
      });
      }
    }else{
      setState(() {
        _menssagemErro = "Preencha o campo nome";
      });
    }
}

_cadastrarUsuario(Usuario usuario){

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
        ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
              TextField(
                 controller:_controllerNome,
                 autofocus: true,
                 keyboardType: TextInputType.text,
                 style: TextStyle(fontSize:20),
                 decoration: InputDecoration(
                   contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                   hintText: "Nome completo",
                   filled: true,
                   fillColor: Colors.white,
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(6)
                     )
                 ),
               ),

               TextField(
                 controller:_controllerEmail,
                 keyboardType: TextInputType.emailAddress,
                 style: TextStyle(fontSize:20),
                 decoration: InputDecoration(
                   contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                   hintText: "e-mail",
                   filled: true,
                   fillColor: Colors.white,
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(6)
                     )
                 ),
               ),
               TextField(
                 controller:_controllerSenha,
                 obscureText: true,
                 keyboardType: TextInputType.emailAddress,
                 style: TextStyle(fontSize:20),
                 decoration: InputDecoration(
                   contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                   hintText: "senha",
                   filled: true,
                   fillColor: Colors.white,
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(6)
                     )
                 ),
               ),
               Padding(
                 padding: EdgeInsets.only(bottom: 10),
                 child: Row(
                   children: <Widget>[
                     Text("Passageiro"),
                     Switch(value: _tipoUsuario, 
                     onChanged: (bool valor){
                       setState(() {
                         _tipoUsuario= valor;
                       });
                     },
                     ),
                     Text("Motorista"),

                   ],
                 ),
               ),

               Padding(
                 padding: EdgeInsets.only(top: 16, bottom:10),
                 child: RaisedButton(
                   child: Text(
                     "Cadastrar",
                     style: TextStyle(color: Colors.white, fontSize: 20),
                     ),
                     color: Color(0xff1ebbd8),
                     padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                   onLongPress: (){
                     _validarCampos;
                   },
                   ),
               ),
                 Padding(
                   padding: EdgeInsets.only(top:16),
                   child: Center(
                     child: Text(
                       _menssagemErro,
                       style: TextStyle(color: Colors.red,fontSize: 20),
                       ),
                     ),
                   ),
              ],
            ) ,
            )
        ),
      )
    );
  }
}