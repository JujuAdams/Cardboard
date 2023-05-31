/// Returns an array of all lights currently added to Cardboard
/// 
/// N.B. Elements in this array are weak references
///      Do not edit this array! Bad things will happen if you do

function CbLightArrayGet()
{
    __CB_GLOBAL
    
    return _global.__lightArray;
}