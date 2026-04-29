// Feather disable all

/// @param state

function CbSetBackfaceCulling(_state)
{
    __CB_GLOBAL_RENDER
    
    _global.__backfaceCulling = _state;
}