import 'character.dart';

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
    character.cHealth -= damage;
    if(character.cHealth < 0) character.cHealth = 0;
    print('$mName이(가) ${character.cName}에게 $damage의 데미지를 입혔습니다.');
  }

  //몬스터의 현재 체력, 공격력 출력
  showStatus(){
    print('$mName - 체력: $mHealth, 공격력: $mAttack, 방어력: $mDefense');
  }
}