function __CbBuildError()
{
    var _string = "";
    
    var _i = 0
    repeat(argument_count)
    {
        _string += string(argument[_i]);
        ++_i;
    }
    
    show_debug_message("CbBuild " + string(__CB_BUILD_VERSION) + ": " + string_replace_all(_string, "\n", "\n          "));
    show_error("CbBuild:\n" + _string + "\n ", true);
}