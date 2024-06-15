/// Starts the building process for a Cardboard model
/// 
/// This function returns <undefined>; CbModelClose() returns the model
///
/// N.B. Any model that is created must also be destroyed with CbModelDestroy() to prevent memory leaks

/// @param model

function CbModelOpen(_model)
{
    __CB_GLOBAL_BUILD
    
    if (_global.__model != undefined) __CbBuildError("Only one model can be created at a time");
    
    __CbBatchComplete();
    _global.__model = _model;
}