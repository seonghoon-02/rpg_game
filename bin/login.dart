import 'dart:io';

class Login {
  String uName = '';
  //로그인 메소드
  login(){
    RegExp regex = RegExp(r'^[a-zA-Z]+$');
    while(true){
      print('이름을 입력하세요_only 영문');
      String? name = stdin.readLineSync();
      if(regex.hasMatch(name!)){
        uName = name;
        print('게임을 시작합니다!');
        return;
      }
      else{
        print('유효하지 않습니다. 영문으로만 입력해주세요.');
      }
    }
  }
}