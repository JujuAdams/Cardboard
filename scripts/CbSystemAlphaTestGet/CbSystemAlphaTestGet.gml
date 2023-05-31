/// Returns the alpha testing reference value for Cardboard
/// 
/// N.B. The alpha test reference value is from 0 to 1 (unlike GameMaker's native function)

function CbSystemAlphaTestGet()
{
    __CB_GLOBAL
    
    return _global.__alphaTestRef;
}