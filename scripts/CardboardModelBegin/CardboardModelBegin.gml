function CardboardModelBegin()
{
    if (global.__cardboardBuildingModel) __CardboardError("Only one model can be created at a time");
    
    __CardboardBatchComplete();
    
    global.__cardboardBuildingModel = true;
    global.__cardboardModel = new __CardboardClassModel();
}