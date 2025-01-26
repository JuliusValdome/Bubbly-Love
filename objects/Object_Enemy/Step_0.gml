Enemy_Defeat();

if (defeatFlag)	return 0;
Enemy_Control();
Enemy_atack();
Enemy_GotHit();

depth = -y;