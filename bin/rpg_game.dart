void main() {

}

//게임을 정의하기 위한 클래스
class Game{
  //게임을 시작하는 메서드
  startGame(){

  }

  //전투를 진행하는 메서드
  battle(){

  }

  //랜덤으로 몬스터를 불러오는 메서드
  getRandomMonster(){

  }
}

//캐릭터를 정의하기 위한 클래스
class Character {
  String cName;  //캐릭터 이름
  int cStamina;  //캐릭터 체력
  int cAttack;   //캐릭터 공격력
  int cDefense;  //캐릭터 방어력

  Character(this.cName, this.cStamina, this.cAttack, this.cDefense);
}