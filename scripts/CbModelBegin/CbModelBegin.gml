/// Starts the building process for a Cb model
/// 
/// This function returns <undefined>; CbModelEnd() returns the model
///
/// N.B. Any model that is created must also be destroyed with CbModelDestroy() to prevent memory leaks

function CbModelBegin()
{
    __CB_GLOBAL_BUILD
    
    if (_global.__model != undefined) __CbError("Only one model can be created at a time");
    
    __CbBatchComplete();
    
    _global.__model = new __CbClassModel();
    
    if (CB_WRITE_NORMALS)
    {
        _global.__modelIndexInteger = _global.__indexInteger - __CB_INDEX_START;
        _global.__indexInteger = 0;
    }
}