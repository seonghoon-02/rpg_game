import 'dart:io';
import 'dart:math';
import 'character.dart';
import 'monster.dart';
import 'save.dart';
import 'logout.dart';

//게임을 정의하기 위한 클래스
class Game{
  Random random = Random();
  Save save = Save();
  Logout logout = Logout();

  List<Monster> monsterList = [];
  late Character character; //loadCharacterStats()에서 정의됨. late사용.
  bool onOff = true;

  void loadCharacterStats(cName) { //캐릭터 불러오기
    try {
      final file = File('../assets/characters.txt');
      final contents = file.readAsStringSync();
      final stats = contents.split(',');
      if (stats.length != 3) throw FormatException('Invalid character data');

      int cHealth = int.parse(stats[0]);
      int cAttack = int.parse(stats[1]);
      int cDefense = int.parse(stats[2]);
      Map<String, String> result = {'monster name' : 'win or lose'};
      int item = 1;
      int cMagicPoint = 20;
      
      character = Character(cName, cHealth, cAttack, cDefense, result, item, cMagicPoint);

      
      if(Random().nextInt(10) < 3){  //캐릭터 생성시 33%확률로 보너스 체력 부여.
        int bonusHealth = 30;
        character.cHealth += bonusHealth;
        print('보너스 체력 $bonusHealth을 었었습니다! 현재 체력: ${character.cHealth}');
      }

    } catch (e) {
      print('캐릭터 데이터를 불러오는 데 실패했습니다: $e');
      exit(1);
    }
  }

  void loadMonsterStats() { //몬스터 불러오기
    try {
      final file = File('../assets/monsters.txt');
      final contents = file.readAsStringSync();
      final stats = contents.split(',');
      if (stats.length != 40) throw FormatException('Invalid character data');

      for(int i = 0; i < 40; i += 4){
        String mName = stats[i];
        int mHealth = int.parse(stats[i + 1]);
        int mAttack = character.cDefense + random.nextInt(int.parse(stats[i + 2]) - character.cDefense) + 1; //min 캐릭터 방어력 +1
        int mDefense = int.parse(stats[i + 3]);
        monsterList.add(Monster(mName, mHealth, mAttack, mDefense));
      }
    } catch (e) {
      print('몬스터 데이터를 불러오는 데 실패했습니다: $e');
      exit(1);
    }
  }

  //게임을 재시작하는 메서드
  bool startGame(Character character){
    if(monsterList.isEmpty){   //몬스터 리스트에 남은 몬스터가 없을시 종료 
        print('모든 몬스터를 물리쳤습니다!');
        save.saveChoice(character);
        return false;
    }

    if(character.cHealth <= 0){
      return false;
    }

    while(true){
      stdout.write('다음 몬스터와 싸우시겠습니까? (y/n): '); //줄바꿈 없이 선택한 번호 출력
      String? choise = stdin.readLineSync();
      if(choise == 'y'){
        return true;
      }else if(choise == 'n'){
        save.saveChoice(character);
        return false;
      }else{
        print('입력값이 유효하지 않습니다. y, n 중에 입력하여 주세요.');
      }
    }
  }

  //전투를 진행하는 메서드
  battle(name){
    print('');
    print('새로운 몬스터가 나타났습니다!');
    Monster monster = getRandomMonster();
    monster.showStatus();
    int turn = 1;

    while(true){
      if(monster.mHealth <= 0){ //몬스터 체력 0되면 break실행
          print('${monster.mName}을(를) 물리쳤습니다!');
          character.result[monster.mName] = 'win';   //결과 기록
          print('');
          break;
        }

      if(character.cHealth <= 0){
        print('${character.cName}이 패배하였습니다.');
        character.result[monster.mName] = 'lose';   //결과 기록
        character.cHealth = 0;
        save.saveChoice(character); //저장여부 확인
        break;
      }

      print('');
      if(turn % 3 == 0){   // 3턴 마다 몬스터 방어력 2 증가
        monster.mDefense += 10;
        print('${monster.mName}의 방어력이 2 증가하였습니다! 현재 방어력: ${monster.mDefense}');
      }
      print('$name의 턴');

      //줄바꿈 없이 선택한 번호 출력
      stdout.write('행동을 선택하세요 (1: 공격, 2: 방어, 3: HP물약 사용_보유 수량 ${character.item}개, 4: 공격력UP 마법 사용_필요 MP: 20, 현재 MP: ${character.cMagicPoint}), 5: 종료 : '); 
      
      String? choise = stdin.readLineSync();

      if(choise == '1'){
        character.attackMonster(monster);
        if(monster.mHealth > 0){
          monster.attackCharacter(character);
        }
        character.showStatus();
        monster.showStatus();
      }else if(choise == '2'){
        character.defend(monster);
        monster.attackCharacter(character);
        character.showStatus();
        monster.showStatus();
      }else if(choise == '3' && character.item > 0){
        character.itemUse();
        monster.attackCharacter(character);
        character.showStatus();
        monster.showStatus();
      }else if(choise == '3' && character.item == 0){
        print('보유 아이템이 없습니다.');
        continue;
      }else if(choise == '4' && character.cMagicPoint >= 20){
        character.magicUse();
        character.attackMonster(monster);
        if(monster.mHealth > 0){
          monster.attackCharacter(character);
        }
        character.cAttack ~/= 2;  //공격력 원상복구
        character.showStatus();
        monster.showStatus();
      }else if(choise == '4' && character.cMagicPoint < 20){
        print('MP가 부족합니다. 필요 MP: 20, 현재 MP: ${character.cMagicPoint}');
        continue;
      }else if(choise == '5'){
        onOff = logout.logout(character, monster);
        break;
      }else{
        print('입력값이 유효하지 않습니다.');
        continue;
      }
      turn++;
    }      
  }

  //랜덤으로 몬스터를 불러오는 메서드
  Monster getRandomMonster(){
    int randomNum;
    if(monsterList.length == 1){  //random.nextInt(0)일때 오류 발생하여 추가함
      randomNum = 0;
    }else{
      randomNum = random.nextInt(monsterList.length-1);
    } 

    Monster monster = monsterList[randomNum]; //랜덤으로 몬스터리스트에서 몬스터 불러오기
    monsterList.removeAt(randomNum);  //몬스터리스트에서 불러온 몬스터 삭제

    return monster;  
  }
}