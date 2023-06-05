function __CbDeferredSurfaceDepthEnsure(_refSurface)
{
    __CB_GLOBAL_RENDER
    
    with(_global.__lighting)
    {
        var _width  = surface_get_width( _refSurface);
        var _height = surface_get_height(_refSurface);
        
        if (surface_exists(__surfaceDepth)
        &&   ((_width  != surface_get_width( __surfaceDepth))
           || (_height != surface_get_height(__surfaceDepth))))
        {
            surface_free(__surfaceDepth);
            __surfaceDepth = -1;
        }
        
        if (not surface_exists(__surfaceDepth))
        {
            __surfaceDepth = surface_create(_width, _height);
        }
        
        return __surfaceDepth;
    }
}