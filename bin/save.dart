import 'dart:io';
import 'character.dart';

class Save {
  var file = File('../save/result.txt');

  saveChoice(Character character){
    while(true){
      stdout.write('저장하시겠습니까? (y/n): '); //줄바꿈 없이 선택한 번호 출력
      String? saveChoise = stdin.readLineSync();
      if(saveChoise == 'y'){
        //캐릭터의 이름, 남은 체력, 게임 결과(승리/패배) 
        String result = 'character name : ${character.cName}, character health : ${character.cHealth}, game result : ${character.result}';
        fileSave(result);
        return;
      }else if(saveChoise == 'n'){
        return;
      }else{
        print('입력값이 유효하지 않습니다. y, n 중에 입력하여 주세요.');
      }
    }
  }

  fileSave(String result){
    String contents = result;
    file.writeAsStringSync(contents);
  }
}