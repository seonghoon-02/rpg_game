import 'dart:io';
import 'save.dart';
import 'character.dart';
import 'monster.dart';

class Logout{
  Save save = Save();

  bool logout(Character character, Monster monster){
    while(true){
      stdout.write('종료하시겠습니까? (y/n): '); //줄바꿈 없이 선택한 번호 출력
      String? logoutChoice = stdin.readLineSync();

      if(logoutChoice == 'y'){  //종료 선택시 저장여부 확인후 종료
        character.result[monster.mName] = 'lose';  //종료 선택 시점의 몬스터 전적 패로 기록
        save.saveChoice(character);
        return false;
      }else if(logoutChoice == 'n'){
        return true;
      }else{
        print('입력값이 유효하지 않습니다. y, n 중에 입력하여 주세요.');
      }
    }
  }
}