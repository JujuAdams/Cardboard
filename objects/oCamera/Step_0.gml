if (keyboard_check_released(vk_f4)) window_set_fullscreen(!window_get_fullscreen());

var _dx = 5*(keyboard_check(ord("D")) - keyboard_check(ord("A")));
var _dy = 5*(keyboard_check(ord("S")) - keyboard_check(ord("W")));
var _dz = 5*(keyboard_check(vk_space) - keyboard_check(vk_shift));

camFromX += _dx;
camFromY += _dy;
camFromZ += _dz;

camToX += _dx;
camToY += _dy;
camToZ += _dz;

yawTarget += 45*(keyboard_check_pressed(ord("E")) - keyboard_check_pressed(ord("Q")));
yaw = lerp(yaw, yawTarget, 0.3);

camFromX = camToX + lengthdir_x(200, yaw);
camFromY = camToY + lengthdir_y(200, yaw);