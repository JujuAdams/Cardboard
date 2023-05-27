function __CardboardBatchComplete()
{
    __CARDBOARD_GLOBAL
    
    if (_global.__buildingModel)
    {
        _global.__model.__AddBatch();
    }
    else
    {
        CardboardBatchForceSubmit();
    }
}