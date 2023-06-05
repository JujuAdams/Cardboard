/// Returns the current lighting mode

function CbBackfaceCullingGet()
{
    __CB_GLOBAL_RENDER
    
    return _global.__backfaceCulling;
}