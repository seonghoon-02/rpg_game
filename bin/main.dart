import 'game.dart';
import 'login.dart';

void main() {
  Login login = Login();
  Game game = Game();
  bool gameContinue = true;

  login.login(); //캐릭터 명 입력
  game.loadCharacterStats(login.uName); //캐릭터파일 읽기
  game.loadMonsterStats(); //몬스터파일 읽기
  print('${game.character.cName} - 체력: ${game.character.cHealth}, 공격력: ${game.character.cAttack}, 방어력: ${game.character.cDefense}');

  while(gameContinue){
    game.battle(login.uName); //배틀 시작
    if(!game.onOff){
      gameContinue = false;  //사용자가 종료 요청하는지 확인
    }else{
      gameContinue = game.startGame(game.character);  //배츨 종료후 재시작 확인
    }
  }
}