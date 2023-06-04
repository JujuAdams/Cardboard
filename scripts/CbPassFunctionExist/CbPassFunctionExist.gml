/// Returns if a function has been defined for the given pass
/// 
/// The pass should be specified using the CB_PASS enum
/// 
/// @param pass

function CbPassFunctionExist(_pass)
{
    __CB_GLOBAL
    
    return (_global.__pass[_pass].__function != undefined)
}