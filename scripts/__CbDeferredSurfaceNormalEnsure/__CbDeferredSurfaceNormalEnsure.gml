function __CbDeferredSurfaceNormalEnsure(_refSurface)
{
    __CB_GLOBAL
    
    with(_global)
    {
        var _width  = surface_get_width( _refSurface);
        var _height = surface_get_height(_refSurface);
        
        if (surface_exists(__deferredSurfaceNormal)
        &&   ((_width  != surface_get_width( __deferredSurfaceNormal))
           || (_height != surface_get_height(__deferredSurfaceNormal))))
        {
            surface_free(__deferredSurfaceNormal);
            __deferredSurfaceNormal = -1;
        }
        
        if (not surface_exists(__deferredSurfaceNormal))
        {
            __deferredSurfaceNormal = surface_create(_width, _height);
        }
        
        return __deferredSurfaceNormal;
    }
}