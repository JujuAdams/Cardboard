function __CbBatchComplete()
{
    __CB_GLOBAL
    
    if (_global.__model != undefined)
    {
        _global.__model.__AddBatch();
    }
    else
    {
        CbBatchForceSubmit();
    }
}