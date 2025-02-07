Attack_General();
Attack_GetSprite();

switch(name){
	case "Lily":
		Attack_Step_Lily();
		break;
	case "Dulce":
		Attack_Step_Dulce();
		break;
	case "Hua":
		Attack_Step_Hua();
		break;
	case "Tanja":
		Attack_Step_Tanja();
		break;
	case "Tanja_Burn":
		Attack_Step_TanjaBurn();
		break;
	case "Miyuki":
		Attack_Step_Miyuki();
		break;
	case "Miyuki_Wave":
		Attack_Step_MiyukiWave();
		break;
}

Attack_DealDamage();

depth = -y;