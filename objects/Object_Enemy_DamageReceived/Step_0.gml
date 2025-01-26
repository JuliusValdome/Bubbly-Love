y -= moveSpeed * SLOW;

maxMove -= (abs(y - yprevious));

if (maxMove <= 0){
	image_alpha -= (1 / (SECOND	* 0.5)) * SLOW;
	
	if (image_alpha <= 0){
		instance_destroy();
	}
}