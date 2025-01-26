HitList = [];
image_xscale = creator.attackInfo.size;
image_yscale = creator.attackInfo.size;

var _x = x + lengthdir_x(creator.attackInfo.hitBoxOffset, attackDirection);
var _y = y + lengthdir_y(creator.attackInfo.hitBoxOffset, attackDirection);

hitbox = instance_create_depth(_x, _y, depth + 1, Object_AttackHitbox, {creator: id, offset: creator.attackInfo.hitBoxOffset, attackDirection: attackDirection});

damage = ceil(info.attack * (isCrit ? critMult : 1));
bounce = true;

switch(name){
	case "A":
		Attack_Variables_A();
		break;
	case "B":
		Attack_Variables_B();
		break;
	case "C":
		Attack_Variables_C();
		break;
	case "D":
		Attack_Variables_D();
		break;
	case "E":
		Attack_Variables_E();
		break;
	case "E_B":
		Attack_Variables_EB();
		break;
}

Attacks_GetSprite();