/// Finishes building a model started by CardboardModelBegin()
/// 
/// This function returns the model that has been built
///
/// N.B. Any model that is created must also be destroyed with CardboardModelDestroy() to prevent memory leaks

function CardboardModelEnd()
{
    if (!global.__cardboardBuildingModel) __CardboardError("No model has been created");
    
    __CardboardBatchComplete();
    
    var _model = global.__cardboardModel;
    
    global.__cardboardBuildingModel = false;
    global.__cardboardModel         = undefined;
    
    return _model;
}