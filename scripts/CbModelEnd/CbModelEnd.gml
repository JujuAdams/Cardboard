/// Finishes building a model started by CbModelBegin()
/// 
/// This function returns the model that has been built
///
/// N.B. Any model that is created must also be destroyed with CbModelDestroy() to prevent memory leaks

function CbModelEnd()
{
    __CB_GLOBAL_BUILD
    
    if (_global.__model == undefined) __CbError("No model has been created");
    
    __CbBatchComplete();
    
    var _model = _global.__model;
    _global.__model = undefined;
    
    if (CB_WRITE_NORMALS)
    {
        _model.__indexMax = _global.__indexInteger;
        
        _global.__indexInteger = _global.__modelIndexInteger;
        _global.__modelIndexInteger = undefined;
    }
    
    return _model;
}