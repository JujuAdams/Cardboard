/// Returns the alpha testing reference value for Cardboard
/// 
/// N.B. The alpha test reference value is from 0 to 1 (unlike GameMaker's native function)

function CbAlphaTestGet()
{
    __CB_GLOBAL_RENDER
    
    return _global.__alphaTestRef;
}