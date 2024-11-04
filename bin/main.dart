import 'dart:io';

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


class Login {

  //로그인 메소드
  login(){
    RegExp regex = RegExp(r'^[a-zA-Z가-힣]+$');
    print('이름을 입력하세요_영문');
    String? uName = stdin.readLineSync();
    if(regex.hasMatch(uName!)){
      print('게임스타트');
      print(uName);
    }
    else{
      print('이게뭐야');
      print(uName);
    }
  }
}

//캐릭터를 정의하기 위한 클래스
class Character {
  String cName;  //캐릭터 이름
  int cStamina;  //캐릭터 체력
  int cAttack;   //캐릭터 공격력
  int cDefense;  //캐릭터 방어력

  Character(this.cName, this.cStamina, this.cAttack, this.cDefense);

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

  Monster(this.mName, this.mStamina, this.mAttack);

  //몬스터가 캐릭터에게 공격하는 메서드
  // attackCharacter(Character character)){

  // }

  showStatus(){

  }
}