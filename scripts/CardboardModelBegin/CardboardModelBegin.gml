function CardboardModelBegin()
{
    CardboardBatchSubmit();
    
    if (!global.__cardboardModel) __CardboardError("Only one model can be created at a time");
    global.__cardboardModel = true;
}