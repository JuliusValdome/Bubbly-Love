/*draw_text(x, y - 48, string(attackTarget));
draw_text(x, y - 96, string(attackTimer) + " / " + string(baseAttackTimer));

draw_circle(x, y, magnet, true);*/
/*
draw_set_font(Font_Default);

draw_text(x, y - 400, "Move Speed: " + string(moveSpeed));
draw_text(x, y - 375, "Magnet: " + string(magnet));
draw_text(x, y - 350, "Atack Speed: " + string(attackSpeed));
//draw_text(x, y - 325, "Damage: " + string(attackInfo.attack));
draw_text(x, y - 300, "Critical %: " + string(attackCritical));
draw_text(x, y - 275, "Critical x: " + string(attackCriticalMultiplier));
//draw_text(x, y - 250, "Attack Size: " + string(attackInfo.size));
//draw_text(x, y - 225, "Duration: " + string(attackInfo));
draw_text(x, y - 200, "AttackInfo: " + string(attackInfo));


/*
	moveSpeed = baseMoveSpeed;
	magnet = baseMagnet;
	attackRange = baseAttackRange;
	attackCritical = baseAttackCritical;
	attackSpeed = baseAttackSpeed;
	skillRecharge = 0;
	skillRechargeTop = info.specialSkillRechargeBase;
	attackInfo = info.attackInfo;
	
			attackInfo: {
				type: "melee",
				level: 1,
				attack: 5,
				life: SECOND * 0.15,
				offSet: 50,
				amount: 1,
				oneContact: false
			},
	
	*/
	///[MoveSpeed, Magnet, AttackSpeed, Damage, Critical, Size, Duration]