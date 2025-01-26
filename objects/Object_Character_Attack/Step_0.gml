Attack_General();
Attacks_GetSprite();

switch(name){
	case "A":
		Attack_Step_A();
		break;
	case "B":
		Attack_Step_B();
		break;
	case "C":
		Attack_Step_C();
		break;
	case "D":
		Attack_Step_D();
		break;
	case "E":
		Attack_Step_E();
		break;
	case "E_B":
		Attack_Step_EB();
		break;
}

Attack_DealDamage();

depth = -y;