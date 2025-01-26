if (x == xprevious){
	var mvSpeed = moveSpeed * SLOW;

	y += (mvSpeed * dir) * SLOW;

	if (y >= (baseY + maxY)){
		dir = -dir;	
	}else if (y <= (baseY - maxY)){
		dir = -dir;	
	}
}

//Protagonist_Move();

if (state == "Move"){
	image_xscale = x > xprevious ? -1 : 1;	
}

depth = (-baseY - maxY);

Protagonist_GameOver();

Health = (Health >= maxHealth) ? maxHealth : Health;