/// Returns whether auto-batching is turned on

function CardboardBatchAutoGet()
{
    __CARDBOARD_GLOBAL
    
    return _global.__autoBatching;
}