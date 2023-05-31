function __CbDeferredSurfaceDiffuseEnsure(_refSurface)
{
    __CB_GLOBAL
    
    with(_global)
    {
        var _width  = surface_get_width( _refSurface);
        var _height = surface_get_height(_refSurface);
        
        if (surface_exists(__deferredSurfaceDiffuse)
        &&   ((_width  != surface_get_width( __deferredSurfaceDiffuse))
           || (_height != surface_get_height(__deferredSurfaceDiffuse))))
        {
            surface_free(__deferredSurfaceDiffuse);
            __deferredSurfaceDiffuse = -1;
        }
        
        if (not surface_exists(__deferredSurfaceDiffuse))
        {
            __deferredSurfaceDiffuse = surface_create(_width, _height);
        }
        
        return __deferredSurfaceDiffuse;
    }
}