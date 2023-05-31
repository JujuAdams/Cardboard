function __CbDeferredSurfaceLightEnsure(_refSurface)
{
    __CB_GLOBAL
    
    with(_global)
    {
        var _width  = surface_get_width( _refSurface);
        var _height = surface_get_height(_refSurface);
        
        if (surface_exists(__deferredSurfaceLight)
        &&   ((_width  != surface_get_width( __deferredSurfaceLight))
           || (_height != surface_get_height(__deferredSurfaceLight))))
        {
            surface_free(__deferredSurfaceLight);
            __deferredSurfaceLight = -1;
        }
        
        if (not surface_exists(__deferredSurfaceLight))
        {
            __deferredSurfaceLight = surface_create(_width, _height);
        }
        
        return __deferredSurfaceLight;
    }
}