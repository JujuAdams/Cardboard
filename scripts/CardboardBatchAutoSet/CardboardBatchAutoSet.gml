/// Turns auto-batching on or off
/// 
/// @param state  Whether to turn on auto-batching

function CardboardBatchAutoSet(_state)
{
    __CARDBOARD_GLOBAL
    
    _global.__autoBatching = _state;
}