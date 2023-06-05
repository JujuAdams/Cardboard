/// Returns whether auto-batching is turned on

function CbBatchAutoGet()
{
    __CB_GLOBAL
    
    return _global.__batch.__auto;
}