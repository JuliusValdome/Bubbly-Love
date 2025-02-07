function Character_Variables(){
	/// Flags ///
	moveFlag = false;
	facingDirection = 1;
	prepareAttack = false;
	attackCooldown = false;
	
	/// Variables ///
	targetPosition = [0, 0];
	attackTarget = -1;
	state = "Idle";
	
	/// Timers ///
	baseAttackTimer = SECOND - attackSpeed * SECOND;
	attackTimer = baseAttackTimer;
	attackCooldownTimeBase = baseAttackTimer / 2;
	attackCooldownTime = attackCooldownTimeBase;
	
	/// Constants ///
	baseFrameSpeed = sprite_get_speed(Sprite_Character_Lily_Move);
}

function Character_GetInfo(){
	var info = Object_System.Characters[$ name];		
	
	moveSpeed = info.moveSpeed;
	magnet = info.magnet;
	attackRange = info.attackRange;
	attackCritical = info.attackCritical;
	attackCriticalMultiplier = info.attackCriticalMultiplier;
	attackSpeed = info.attackSpeed;
	
	var attackInfoAux = {};
	attackInfoAux.attack = info.attackInfo.attack;
	attackInfoAux.moveSpeed = info.attackInfo.moveSpeed;
	attackInfoAux.life = info.attackInfo.life;
	attackInfoAux.offset = info.offset;
	attackInfoAux.amount = info.attackInfo.amount;
	attackInfoAux.oneContact = info.attackInfo.oneContact;
	attackInfoAux.size = info.attackInfo.size;
		
	attackInfo = attackInfoAux;
}

function Stats_Update(){
	Character_GetInfo();
	var level = SYS.girlsLevel[? name];
	
	var moveSpeedMult = 1;
	var magnetMult = 1;
	var attackSpeedMult = 1;
	var attackMult = 1;
	var criticalMult = 1;
	var criticalMultiplierMult = 1;
	var sizeMult = 1;
	var amountBoost = 0;
	
	/// CHARACTER LEVELS ///
	switch(name){
		case "Lily":{
			switch(level){
				case 6:
					moveSpeedMult += 0.15;
					magnetMult += 0.15;
					attackSpeedMult += 0.15;
					attackMult += 0.15;
					criticalMult += 0.15;
					criticalMultiplierMult += 0.15;
					sizeMult += 0.15;
					amountBoost += 1;
				case 5:
					sizeMult += 0.35;
				case 4:
					criticalMultiplierMult += 0.1;
				case 3:
					amountBoost += 1;
				case 2:
					attackMult += 0.5;
			}
		}
		break;
		case "Dulce":{
			switch(level){
				case 6:
					attackSpeedMult += 0.4;
				case 5:
					amountBoost += 1;
				case 4:
					sizeMult += 0.2;
				case 3:
					amountBoost += 1;
				case 2:
					criticalMult += 0.20;
			}
		}
		break;
		case "Hua":{
			switch(level){
				case 6:
				case 5:
					attackCritical += attackCritical * 0.15;
				case 4:
				case 3:
					attackInfo.moveSpeed = bulletSpeed * 1.35;
				case 2:
					attackRange += attackRange * 0.25;
			}
		}
		break;
		case "Tanja":{
			switch(level){
				case 6:
					attackCriticalMultiplier += attackCriticalMultiplier * 0.25;
				case 5:
					attackInfo.size += attackInfo.size * 0.2;
				case 4:
				case 3:
					attackInfo.moveSpeed = bulletSpeed * 1.05;
				case 2:
					attackInfo.life += attackInfo.life * 0.4;
			}
		}
		break;
		case "Miyuki":{
			switch(level){
				case 6:
					attackInfo.attack += attackInfo.attack * 0.35;
				case 5:
				case 4:
					attackCriticalMultiplier += attackCriticalMultiplier * 0.5;
				case 3:
					moveSpeed += moveSpeed * 0.5;
				case 2:
					attackSpeed += attackSpeed * 0.3;
			}
		}
		break;
	}		
	
	/// ITEMS ///
	moveSpeedMult += SYS.itemsLevel[? "Letter"] * 0.1;
	magnetMult += SYS.itemsLevel[? "Ring"] * 0.075;
	attackSpeedMult += SYS.itemsLevel[? "BubbleTea"] * 0.05;
	sizeMult += SYS.itemsLevel[? "Button"] * 0.1;
	attackMult += SYS.itemsLevel[? "Flower"] * 0.4;
	amountBoost += SYS.itemsLevel[? "StuffedAnimal"] * 0.5;
	criticalMult += SYS.itemsLevel[? "Magazine"] * 0.25;
	criticalMultiplierMult += SYS.itemsLevel[? "Socks"] * 0.25;

	/// FINAL CALCULATION ///
	moveSpeed *= moveSpeedMult;
	magnet *= magnetMult;
	attackCritical += criticalMult;
	attackCriticalMultiplier += criticalMultiplierMult;
	attackSpeed += attackSpeedMult;
	attackInfo.attack *= attackMult;
	attackInfo.size *= sizeMult;
	attackInfo.amount = floor(attackInfo.amount + amountBoost);	
}