camera = instance_create_depth(x, y, depth, Object_Camera);
windowSize = [window_get_width(), window_get_height()];

selectedBubble = false;
resumeTimerBase = SECOND * 0.25;
resumeTimer = resumeTimerBase;

gameOverTransitionAlphaBlack = 0;