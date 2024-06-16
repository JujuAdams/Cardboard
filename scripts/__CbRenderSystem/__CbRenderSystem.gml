#macro __CB_RENDER_VERSION  "3.0.0"
#macro __CB_RENDER_DATE     "2024-06-16"

#macro __CB_LIGHT_COUNT  6

#macro __CB_SURFACE_SET_TARGET_EXT_WORKAROUND  true

enum CB_PASS
{
    DEPTH_MAP,
    LIT_OPAQUE,
    LIT_ALPHA_BLEND,
    UNLIT_OPAQUE,
    UNLIT_ALPHA_BLEND,
    __SIZE
}

enum CB_LIGHT_MODE
{
    DISABLE_LIGHTING,
    NO_SHADOWED_LIGHTS,
    ONE_SHADOWED_LIGHT,
    DEFERRED,
}

#macro __CB_RENDER_OPENGL  (((os_type != os_windows) && (os_type != os_xboxone) && (os_type != os_xboxseriesxs)) || (os_browser != browser_not_a_browser))
#macro __CB_GLOBAL_RENDER  static _global = __CbRenderSystem();

__CbRenderSystem();
function __CbRenderSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    __CbRenderTrace("Welcome to Cardboard Render by Juju Adams! This is version " + __CB_RENDER_VERSION + ", " + __CB_RENDER_DATE);
    
    _system = {};
    with(_system)
    {
        __alphaTestRef      = 0.5;
        __surfaceWorkaround = false;
        __backfaceCulling   = true;
        
        __fog = {
            __enabled: false,
            __color:   c_black,
            __near:    500,
            __far:     1000,
        };
        
        __lighting = {
            __lightMode: CB_LIGHT_MODE.DISABLE_LIGHTING,
            __lightStructArray: [],
            
            __ambient:     c_white,
            __posRadArray: array_create(4*__CB_LIGHT_COUNT, 0),
            __colorArray:  array_create(3*__CB_LIGHT_COUNT, 0),
            
            __defaultDepthFunction: undefined,
            
            __surfaceNormal: -1,
            __surfaceLight:  -1,
        };
    };
    
    return _system;
}