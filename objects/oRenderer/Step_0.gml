//Toggle fullscreen
if (keyboard_check_released(vk_f4)) window_set_fullscreen(!window_get_fullscreen());

//Toggle axonometric mode
if (keyboard_check_pressed(ord("X"))) CbCameraAxonometricSet(!CbCameraAxonometricGet());

light1.x     = oCamera.camToX;
light1.y     = oCamera.camToY + 10;
light2.xFrom = oCamera.camToX;
light2.yFrom = oCamera.camToY + 30;
light2.xTo   = oCamera.camToX + 100*dsin(current_time/20);
light2.yTo   = oCamera.camToY;