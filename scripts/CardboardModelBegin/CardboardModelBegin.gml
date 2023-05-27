/// Starts the building process for a Cardboard model
/// 
/// This function returns <undefined>; CardboardModelEnd() returns the model
///
/// N.B. Any model that is created must also be destroyed with CardboardModelDestroy() to prevent memory leaks

function CardboardModelBegin()
{
    __CARDBOARD_GLOBAL
    
    if (_global.__buildingModel) __CardboardError("Only one model can be created at a time");
    
    __CardboardBatchComplete();
    
    _global.__buildingModel = true;
    _global.__model = new __CardboardClassModel();
}