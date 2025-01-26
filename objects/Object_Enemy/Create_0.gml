CharacterEnemy_GetInfo();
CharacterEnemy_Variables();
CharacterEnemy_Sprite();

speed = MoveSpeed * SLOW;

FlagMove = room_speed * 5;

hitTimer = SECOND / 2;
hitTimerBase = SECOND / 2;

hitBox = instance_create_depth(x, y, depth - 1, Object_Enemy_HitBox, {creator: id});