// Feather disable all

/// Returns whether double-sided drawing is enabled

function CbGetDoubleSided()
{
    __CB_GLOBAL_BUILD
    
    return _global.__doubleSided;
}