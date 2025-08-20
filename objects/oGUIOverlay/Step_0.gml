if (keyboard_check_released(vk_f1)) showInfo = !showInfo;

fpsSmoothed = lerp(fpsSmoothed, fps_real, 0.02);