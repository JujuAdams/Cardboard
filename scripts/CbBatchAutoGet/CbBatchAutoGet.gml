/// Returns whether auto-batching is turned on

function CbBatchAutoGet()
{
    __CB_GLOBAL_BUILD
    
    return _global.__batch.__auto;
}