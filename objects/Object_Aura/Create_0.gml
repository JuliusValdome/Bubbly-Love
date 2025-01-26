image_alpha = .25;
DestroyCont = SECOND;

HpHealed = 3;
//FlagHealed = true;

with(Object_Enemy){
	if (id == other.creator.id) break;
	
	if (place_meeting(x, y, other)){
		Health += other.HpHealed;
		Health = Health >= maxHealth ? maxHealth : Health;
	}
}