import 'dart:io';
import 'dart:math';

void main() {
  Login login = Login();
  Game game = Game();

  login.login();
  game.loadCharacterStats(login.uName);
  game.loadMonsterStats();
  print('${game.character.cName} - 체력: ${game.character.cHealth}, 공격력: ${game.character.cAttack}, 방어력: ${game.character.cDefense}');
  game.battle(login.uName);

}

//게임을 정의하기 위한 클래스
class Game{
  Random random = Random();
  List<Monster> monsterList = [];
  late Character character; //loadCharacterStats()에서 정의됨. late사용.

  void loadCharacterStats(name) {
    try {
      final file = File('../assets/characters.txt');
      final contents = file.readAsStringSync();
      final stats = contents.split(',');
      if (stats.length != 3) throw FormatException('Invalid character data');
        
      int health = int.parse(stats[0]);
      int attack = int.parse(stats[1]);
      int defense = int.parse(stats[2]);

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
        String name = stats[i];
        int health = int.parse(stats[i + 1]);
        int attack = random.nextInt(int.parse(stats[i + 2]));
        int defense = int.parse(stats[i + 3]);
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
  battle(name){
    print('');
    print('새로운 몬스터가 나타났습니다!');
    Monster monster = getRandomMonster();
    print('${monster.mName} - 체력: ${monster.mHealth}, 공격력: ${monster.mAttack}');

    while(true){
      print('');
      print('$name의 턴');
      stdout.write('행동을 선택하세요 (1: 공격, 2: 방어): '); //줄바꿈 없이 선택한 번호 출력
      String? choise = stdin.readLineSync();
      if(choise == '1'){
        character.attackMonster(monster);
      }else if(choise == '2'){

      }else{
        print('입력값이 유효하지 않습니다. 1, 2 중에 입력하여 주세요.');
      }

      if(monster.mHealth > 0){
        monster.attackCharacter(character);
        character.showStatus();
        monster.showStatus();
      }else{
        print('${monster.mName}을(를) 물리쳤습니다!');
        break;
      }

    }
    
  }

  //랜덤으로 몬스터를 불러오는 메서드
  Monster getRandomMonster(){
    return monsterList[random.nextInt(monsterList.length-1)];  //랜덤으로 몬스터리스트에서 몬스터 불러오기
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
      print('유효하지 않습니다. 영문으로만 입력해주세요.');
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
  attackMonster(Monster monster){
    print('$cName이(가) ${monster.mName}에게 $cAttack의 데미지를 입혔습니다.');
    monster.mHealth -= cAttack;
  }

  //방어 메서드
  defend(){

  }

  //상태 출력 메서드
  showStatus(){
    print('$cName - 체력: $cHealth, 공격력: $cAttack, 방어력: $cDefense');
  }
}

//몬스터를 정의하기 위한 클래스
class Monster {
  String mName;  //몬스터 이름
  int mHealth;  //몬스터 체력
  int mAttack;   //몬스터 공격력(캐릭터 방어력<= 랜덤 <=최대값)
  int mDefense = 0;  //몬스터 방어력(0)

  Monster(this.mName, this.mHealth, this.mAttack, this.mDefense);

  //몬스터가 캐릭터에게 공격하는 메서드
  attackCharacter(Character character){
    print('');
    print('$mName의 턴');
    int damage = mAttack - character.cDefense;  //캐릭터의 방어력만큼 데미지 차감
    if(damage < 0){
      damage = 0;
    }
    print('$mName이(가) ${character.cName}에게 $damage의 데미지를 입혔습니다.');
    character.cHealth -= damage;
  }

  //몬스터의 현재 체력, 공격력 출력
  showStatus(){
    print('$mName - 체력: $mHealth, 공격력: $mAttack');
  }
}