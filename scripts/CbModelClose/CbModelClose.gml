/// Finishes building a model started by CbModelOpen()
/// 
/// This function returns the model that has been built
///
/// N.B. Any model that is created must also be destroyed with CbModelDestroy() to prevent memory leaks

function CbModelClose()
{
    __CB_GLOBAL_BUILD
    
    if (_global.__model == undefined) __CbBuildError("No model has been created");
    
    __CbBatchComplete();
    _global.__model = undefined;
}