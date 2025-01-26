randomize();

#macro SECOND room_speed
#macro TWR Object_Tower
#macro SLOW ((global.LevelUpEvent or !global.GameOverEvent or TWR.gameOverTransition) ? global.pGameSpeed : (global.slowMotion ? (global.sGameSpeed + global.slowMoTimer) : global.nGameSpeed))
#macro MBRight mouse_check_button(mb_right)
#macro MBRightRel mouse_check_button_released(mb_right)
#macro SYS Object_System
#macro D_ONE -= 1 * SLOW

ButtomFlag = true;
NumPortal = 0;

LevelEnemy = 1;

BossFlag = false;

FlagYouWin = false;

TimerWin = SECOND;

System_Create_Variables();
System_Create_Globals();
System_Create_Config();
System_Create_CharacterInfo();
//System_Create_Objects();