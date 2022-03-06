/// Starts the building process for a Cardboard model
/// 
/// This function returns <undefined>; CardboardModelEnd() returns the model
///
/// N.B. Any model that is created must also be destroyed with CardboardModelDestroy() to prevent memory leaks

function CardboardModelBegin()
{
    if (global.__cardboardBuildingModel) __CardboardError("Only one model can be created at a time");
    
    __CardboardBatchComplete();
    
    global.__cardboardBuildingModel = true;
    global.__cardboardModel = new __CardboardClassModel();
}