import 'dart:io';
import 'dart:math';

void main() {
  Login login = Login();
  Game game = Game();

  login.login();
  game.loadCharacterStats();
  print('${game.character.cName} - 체력: ${game.character.cHealth}, 공격력: ${game.character.cAttack}, 방어력: ${game.character.cDefense}');

}

//게임을 정의하기 위한 클래스
class Game{
  Login start = Login();
  List<Monster> monsterList = [];
  late Character character; //loadCharacterStats()에서 정의됨. late사용.

  void loadCharacterStats() {
    try {
      final file = File('../assets/characters.txt');
      final contents = file.readAsStringSync();
      final stats = contents.split(',');
      if (stats.length != 3) throw FormatException('Invalid character data');
        
      int health = int.parse(stats[0]);
      int attack = int.parse(stats[1]);
      int defense = int.parse(stats[2]);
        
      String name = start.uName;
      character = Character(name, health, attack, defense);
    } catch (e) {
      print('캐릭터 데이터를 불러오는 데 실패했습니다: $e');
      exit(1);
    }
  }

  void loadMonsterStats() {
    try {
      final file = File('../assets/monsters.txt');
      final contents = file.readAsStringSync();
      final stats = contents.split(',');
      if (stats.length != 40) throw FormatException('Invalid character data');

      for(int i = 0; i < 40; i += 4){
        String name = stats[0];
        int health = int.parse(stats[1]);
        int attack = Random().nextInt(int.parse(stats[2])-5) + 5;
        int defense = int.parse(stats[3]);
        monsterList.add(Monster(name, health, attack, defense));
      }        
    } catch (e) {
      print('몬스터 데이터를 불러오는 데 실패했습니다: $e');
      exit(1);
    }
  }


  //게임을 재시작하는 메서드
  startGame(){

  }

  //전투를 진행하는 메서드
  battle(){

  }

  //랜덤으로 몬스터를 불러오는 메서드
  getRandomMonster(){

  }
}


class Login {
  String uName = '';
  //로그인 메소드
  login(){
    RegExp regex = RegExp(r'^[a-zA-Z가-힣]+$');
    print('이름을 입력하세요_only 영문');
    String? name = stdin.readLineSync();
    if(regex.hasMatch(name!)){
      uName = name;
      print('게임을 시작합니다!');
    }
    else{
      print('유요하지 않습니다. 영문으로만 입력해주세요.');
    }
  }
}

//캐릭터를 정의하기 위한 클래스
class Character {
  String cName;  //캐릭터 이름
  int cHealth;  //캐릭터 체력
  int cAttack;   //캐릭터 공격력
  int cDefense;  //캐릭터 방어력

  Character(this.cName, this.cHealth, this.cAttack, this.cDefense);

  //캐릭터가 몬스터에게 공격하는 메서드
  // attackMonster(Monster monster){

  // }

  //방어 메서드
  defend(){

  }

  //상태 출력 메서드
  showStatus(){

  }
}

//몬스터를 정의하기 위한 클래스
class Monster {
  String mName;  //몬스터 이름
  int mStamina;  //몬스터 체력
  int mAttack;   //몬스터 공격력(캐릭터 방어력<= 랜덤 <=최대값)
  int mDefense = 0;  //몬스터 방어력(0)

  Monster(this.mName, this.mStamina, this.mAttack, this.mDefense);

  //몬스터가 캐릭터에게 공격하는 메서드
  // attackCharacter(Character character)){

  // }

  showStatus(){

  }
}