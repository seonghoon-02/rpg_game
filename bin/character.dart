import 'monster.dart';

//캐릭터를 정의하기 위한 클래스
class Character {
  String cName;  //캐릭터 이름
  int cHealth;  //캐릭터 체력
  int cAttack;   //캐릭터 공격력
  int cDefense;  //캐릭터 방어력
  Map<String, String> result; //전적 기록
  bool item;

  Character(this.cName, this.cHealth, this.cAttack, this.cDefense, this.result, this.item);

  //캐릭터가 몬스터에게 공격하는 메서드
  attackMonster(Monster monster){
    print('$cName이(가) ${monster.mName}에게 $cAttack의 데미지를 입혔습니다.');
    monster.mHealth -= cAttack;
  }

  //방어 메서드
  defend(Monster monster){
    int heal = monster.mAttack - cDefense;
    if(heal < 0){
      heal = 0;
    }
    cHealth += heal;
    print('$cName이(가) 방어 태세를 취하여 $heal 만큼 체력을 얻었습니다.');
  }

  //상태 출력 메서드
  showStatus(){
    int health;
    if (cHealth < 0){   //체력에 -표시 안나도록
      health = 0;
    }else{
      health = cHealth;
    }
    print('$cName - 체력: $health, 공격력: $cAttack, 방어력: $cDefense');
  }

  //item사용시 공격력 2배
  itemUse(){
    cAttack *= 2;
    print('이번 턴에 공격력이 2배 증가하였습니다. 공격력: $cAttack');
    item = false;
  }
}