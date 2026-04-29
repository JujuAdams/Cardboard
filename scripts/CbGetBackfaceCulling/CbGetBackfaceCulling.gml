// Feather disable all

/// Returns the current lighting mode

function CbGetBackfaceCulling()
{
    __CB_GLOBAL_RENDER
    
    return _global.__backfaceCulling;
}