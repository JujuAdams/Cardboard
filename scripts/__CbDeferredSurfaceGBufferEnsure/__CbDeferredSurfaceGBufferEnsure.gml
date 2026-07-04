// Feather disable all

function __CbDeferredSurfaceGBufferEnsure(_refSurface)
{
    __CB_GLOBAL_RENDER
    
    with(_global.__lighting)
    {
        var _width  = surface_get_width( _refSurface);
        var _height = surface_get_height(_refSurface);
        
        if (surface_exists(__surfaceGBuffer)
        &&   ((_width  != surface_get_width( __surfaceGBuffer))
           || (_height != surface_get_height(__surfaceGBuffer))))
        {
            surface_free(__surfaceGBuffer);
            __surfaceGBuffer = -1;
        }
        
        if (not surface_exists(__surfaceGBuffer))
        {
            __surfaceGBuffer = surface_create(_width, _height, surface_rgba32float);
        }
        
        return __surfaceGBuffer;
    }
}