function __CbDeferredSurfaceLightEnsure(_refSurface)
{
    __CB_GLOBAL
    
    with(_global.__lighting)
    {
        var _width  = surface_get_width( _refSurface);
        var _height = surface_get_height(_refSurface);
        
        if (surface_exists(__surfaceLight)
        &&   ((_width  != surface_get_width( __surfaceLight))
           || (_height != surface_get_height(__surfaceLight))))
        {
            surface_free(__surfaceLight);
            __surfaceLight = -1;
        }
        
        if (not surface_exists(__surfaceLight))
        {
            __surfaceLight = surface_create(_width, _height);
        }
        
        return __surfaceLight;
    }
}