draw_text(x, y - 200, "Move Speed: " + string(moveSpeed));
draw_text(x, y - 175, "Magnet: " + string(magnet));
draw_text(x, y - 150, "Critical: " + string(attackCritical) + "%");
draw_text(x, y - 125, "Critical Multiplier: x" + string(attackCriticalMultiplier));
draw_text(x, y - 100, "Attack Speed: " + string(attackSpeed));
draw_text(x, y - 75, "Damage: " + string(attackInfo.attack));
draw_text(x, y - 50, "Size: " + string(attackInfo.size) + "%");
draw_text(x, y - 25, "Attacks: " + string(attackInfo.amount));