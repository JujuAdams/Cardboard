function __CbDeferredSurfaceNormalEnsure(_refSurface)
{
    __CB_GLOBAL_RENDER
    
    with(_global.__lighting)
    {
        var _width  = surface_get_width( _refSurface);
        var _height = surface_get_height(_refSurface);
        
        if (surface_exists(__surfaceNormal)
        &&   ((_width  != surface_get_width( __surfaceNormal))
           || (_height != surface_get_height(__surfaceNormal))))
        {
            surface_free(__surfaceNormal);
            __surfaceNormal = -1;
        }
        
        if (not surface_exists(__surfaceNormal))
        {
            __surfaceNormal = surface_create(_width, _height);
        }
        
        return __surfaceNormal;
    }
}