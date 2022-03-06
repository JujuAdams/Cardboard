/// Turns auto-batching on or off
/// 
/// @param state  Whether to turn on auto-batching

function CardboardBatchAutoSet(_state)
{
    global.__cardboardAutoBatching = _state;
}