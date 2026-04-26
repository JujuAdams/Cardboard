// Feather disable all

/// Returns whether auto-batching is turned on

function CbBatchGetAuto()
{
    __CB_GLOBAL_BUILD
    
    return _global.__batch.__auto;
}