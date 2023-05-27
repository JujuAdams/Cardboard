/// Finishes building a model started by CardboardModelBegin()
/// 
/// This function returns the model that has been built
///
/// N.B. Any model that is created must also be destroyed with CardboardModelDestroy() to prevent memory leaks

function CardboardModelEnd()
{
    __CARDBOARD_GLOBAL
    
    if (!_global.__buildingModel) __CardboardError("No model has been created");
    
    __CardboardBatchComplete();
    
    var _model = _global.__model;
    
    _global.__buildingModel = false;
    _global.__model         = undefined;
    
    return _model;
}