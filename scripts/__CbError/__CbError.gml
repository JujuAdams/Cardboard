function __CbError()
{
    var _string = "";
    
    var _i = 0
    repeat(argument_count)
    {
        _string += string(argument[_i]);
        ++_i;
    }
    
    show_debug_message("Cb " + string(__CB_VERSION) + ": " + string_replace_all(_string, "\n", "\n          "));
    show_error("Cb " + string(__CB_VERSION) + ":\n" + _string + "\n ", true);
}