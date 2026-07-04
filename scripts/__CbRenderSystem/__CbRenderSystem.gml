// Feather disable all

#macro __CB_LIGHT_COUNT  6

#macro __CB_GLOBAL_RENDER  static _global = __CbRenderSystem();

__CbRenderSystem();
function __CbRenderSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    __CbRenderTrace("Welcome to Cardboard Render by Juju Adams! This is version " + CB_RENDER_VERSION + ", " + CB_RENDER_DATE);
    
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
            __lightMode: CB_LIGHTING_DISABLED,
            __lightStructArray: [],
            
            __ambient:     c_white,
            __posRadArray: array_create(4*__CB_LIGHT_COUNT, 0),
            __colorArray:  array_create(3*__CB_LIGHT_COUNT, 0),
            
            __defaultDepthFunction: undefined,
            
            __surfaceGBuffer: -1,
            __surfaceLight:  -1,
        };
    };
    
    return _system;
}