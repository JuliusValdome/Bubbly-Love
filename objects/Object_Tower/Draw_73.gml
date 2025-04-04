if (!global.LevelUpEvent){

	var radius = 150; // Distancia desde el centro de la torre a donde aparecen las flechas
	var spr = Sprite_Portal_Direction; // Sprite de la flecha

	with (Object_SpawnEnemy) {
	    // Calcular ángulo desde la torre hacia este portal
	    var angle = point_direction(TWR.x, TWR.y, x, y);

	    // Calcular posición sobre la circunferencia
	    var fx = TWR.x + lengthdir_x(radius, angle);
	    var fy = TWR.y + lengthdir_y(radius, angle);

	    // Dibujar la flecha en esa posición, rotada hacia el portal
	    draw_sprite_ext(spr, 0, fx, fy, 1, 1, angle, c_white, 1);
	}
}