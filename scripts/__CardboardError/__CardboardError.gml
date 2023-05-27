function __CardboardError()
{
    var _string = "";
    
    var _i = 0
    repeat(argument_count)
    {
        _string += string(argument[_i]);
        ++_i;
    }
    
    show_debug_message("Cardboard " + string(__CARDBOARD_VERSION) + ": " + string_replace_all(_string, "\n", "\n          "));
    show_error("Cardboard " + string(__CARDBOARD_VERSION) + ":\n" + _string + "\n ", true);
}