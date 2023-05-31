//Toggle fullscreen
if (keyboard_check_released(vk_f4)) window_set_fullscreen(!window_get_fullscreen());

//Toggle axonometric mode
if (keyboard_check_pressed(ord("X"))) CbCameraAxonometricSet(!CbCameraAxonometricGet());