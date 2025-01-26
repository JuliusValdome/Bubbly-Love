if x < Object_Tower.x{
	image_xscale = -1;
}

DestroyTem -= 1 * SLOW;
if DestroyTem <= 0{
	Script_EnemyDamage();
	instance_destroy();
}

var dir = point_direction(x, y, TWR.x, TWR.y);
x += lengthdir_x(5, dir);
y += lengthdir_y(5, dir);