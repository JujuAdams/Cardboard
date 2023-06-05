if (show_info)
{
    var _string  = "Cardboard " + __CB_VERSION + "\n";
        _string += "@jujuadams " + __CB_DATE + "\n";
        _string += "\n";
        _string += "FPS = " + string(fps) + " (" + string(fps_smoothed) + ")\n";
        _string += "\n";
        _string += "WASD/shift/space to move camera\n";
        _string += "Q/E to rotate camera\n";
        _string += "F1 to toggle this panel\n";
        _string += "F4 to toggle fullscreen";
    
    draw_set_colour(c_black);
    draw_set_alpha(0.5);
    draw_rectangle(10, 10, 20+string_width(_string), 20+string_height(_string), false);
    draw_text(15, 16, _string);
    draw_set_alpha(1.0);
    draw_text(14, 15, _string);
    draw_text(16, 15, _string);
    draw_text(15, 14, _string);
    draw_text(15, 16, _string);
    draw_set_colour(c_white);
    draw_text(15, 15, _string);
}