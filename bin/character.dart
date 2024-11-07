import 'monster.dart';

//캐릭터를 정의하기 위한 클래스
class Character {
  String cName;  //캐릭터 이름
  int cHealth;  //캐릭터 체력
  int cAttack;   //캐릭터 공격력
  int cDefense;  //캐릭터 방어력
  Map<String, String> result; //전적 기록
  int item;
  int cMagicPoint;

  Character(this.cName, this.cHealth, this.cAttack, this.cDefense, this.result, this.item, this.cMagicPoint);

  //캐릭터가 몬스터에게 공격하는 메서드
  attackMonster(Monster monster){
    print('$cName이(가) ${monster.mName}에게 $cAttack의 데미지를 입혔습니다.');
    monster.mHealth -= cAttack;
    if(monster.mHealth < 0) monster.mHealth = 0;  //음수일 경우 0입력
  }

  //방어 메서드
  defend(Monster monster){
    int heal = monster.mAttack - cDefense;
    if(heal < 0){
      heal = 0;
    }
    cHealth += heal;
    cMagicPoint += 10;
    print('$cName이(가) 방어 태세를 취하여 체력 $heal, MP 10만큼을 얻었습니다.');
  }

  //상태 출력 메서드
  showStatus(){
    print('$cName - 체력: $cHealth, 공격력: $cAttack, 방어력: $cDefense');
  }

  //item사용시 cHealth 20증가
  itemUse(){
    cHealth += 20;
    item = 0;
    print('체력이 20 증가하였습니다. 현재 체력: $cHealth');
  }

  //magic 사용시 공격력 2배
  magicUse(){
    cAttack *= 2;
    cMagicPoint -= 20;
    print('이번 턴에 공격력이 2배 증가하였습니다. 공격력: $cAttack');
  }
}