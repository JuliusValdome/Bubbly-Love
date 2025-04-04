baseY = y;
maxY = 10;
floatSpeed = 0.25;
dir = 1;

moveSpeed = 8;
moveFlag = false;
spawnMove = true;

state = "Idle";

switch(name){
	case "Love":
		value = random_range(0.8, 1.8) * (SYS.LevelEnemy * 0.75);
		range = 0.8;
		break;
	case "Healing":
		value = floor(irandom_range(3, 5) * SYS.LevelEnemy * 0.75);
		range = 0.5;
		break;
	case "AntiPanic":
		activateFlag = false;
		range = 0.2;
		break;
	case "Magnet":
		range = 0.4;
		break;
}

var dist = irandom_range(100, 150);
var ang = choose(irandom_range(0, 45), irandom_range(135, 180));
var _x = x + lengthdir_x(dist, ang);
var _y = y + lengthdir_y(dist, ang);
var mid = dist / 2;

targetSpawn = {
	targetX: _x,
	targetY: _y,
	pivotX:  x + lengthdir_x(mid, ang),
	pivotY: y + lengthdir_y(mid, ang),
	angleStart: ang > 90 ? 0 : 180,
	midPoint: mid,
	direct: ang > 90 ? 1 : -1
}

sprite_index = asset_get_index("Sprite_" + name + "Bubble_" + state);