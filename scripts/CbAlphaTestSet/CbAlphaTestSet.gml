/// Sets the alpha testing reference value for Cardboard
/// 
/// N.B. The alpha test reference value is from 0 to 1 (unlike GameMaker's native function)
/// 
/// @param alphaTestRef

function CbAlphaTestSet(_alphaTestRef)
{
    __CB_GLOBAL_RENDER
    
    _global.__alphaTestRef = clamp(_alphaTestRef, 0, 1);
}