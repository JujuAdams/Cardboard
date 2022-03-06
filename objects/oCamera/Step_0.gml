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

var _distance = point_distance(camToX, camToY, camFromX, camFromY);
var _direction = point_direction(camToX, camToY, camFromX, camFromY);
_direction += (keyboard_check(ord("Q")) - keyboard_check(ord("E")));
camFromX = camToX + lengthdir_x(_distance, _direction);
camFromY = camToY + lengthdir_y(_distance, _direction);