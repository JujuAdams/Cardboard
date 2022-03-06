if (keyboard_check_released(vk_f1)) show_info = !show_info;

fps_smoothed = lerp(fps_smoothed, fps_real, 0.1);