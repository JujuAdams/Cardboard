function __CbBatchComplete()
{
    __CB_GLOBAL
    
    if (_global.__buildingModel)
    {
        _global.__model.__AddBatch();
    }
    else
    {
        CbBatchForceSubmit();
    }
}