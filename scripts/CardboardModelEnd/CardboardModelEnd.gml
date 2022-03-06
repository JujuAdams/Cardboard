function CardboardModelEnd()
{
    if (!global.__cardboardBuildingModel) __CardboardError("No model has been created");
    
    __CardboardBatchComplete();
    
    var _model = global.__cardboardModel;
    
    global.__cardboardBuildingModel = false;
    global.__cardboardModel         = undefined;
    
    return _model;
}