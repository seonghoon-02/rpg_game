import 'game.dart';
import 'login.dart';

void main() {
  Login login = Login();
  Game game = Game();
  bool gameContinue = true;

  login.login();
  game.loadCharacterStats(login.uName);
  game.loadMonsterStats();
  print('${game.character.cName} - 체력: ${game.character.cHealth}, 공격력: ${game.character.cAttack}, 방어력: ${game.character.cDefense}');

  while(gameContinue){
    game.battle(login.uName);
    gameContinue = game.startGame(game.character);
  }
}