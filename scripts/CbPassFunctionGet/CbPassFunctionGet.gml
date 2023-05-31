/// Returns the function to call when rendering the given pass
/// 
/// The pass should be specified using the CB_PASS enum
/// 
/// @param pass

function CbPassFunctionGet(_pass)
{
    __CB_GLOBAL
    
    return _global.__pass[_pass].__function;
}