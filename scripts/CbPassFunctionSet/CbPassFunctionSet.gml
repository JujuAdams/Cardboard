/// Sets the function to call when rendering the given pass
/// 
/// The pass should be specified using the CB_PASS enum
/// 
/// @param pass/array
/// @param function

function CbPassFunctionSet(_pass, _function)
{
    __CB_GLOBAL
    
    if (is_array(_pass))
    {
        var _i = 0;
        repeat(array_length(_pass))
        {
            CbPassFunctionSet(_pass[_i], _function);
            ++_i;
        }
        
        return;
    }
    
    _global.__pass[_pass].__function = _function;
}