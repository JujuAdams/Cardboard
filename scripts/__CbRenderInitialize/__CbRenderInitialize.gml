#macro __CB_RENDER_VERSION  "2.0.0"
#macro __CB_RENDER_DATE     "2023-06-05"

#macro __CB_LIGHT_COUNT  6

#macro __CB_SURFACE_SET_TARGET_EXT_WORKAROUND  true

enum CB_PASS
{
    LIGHT_DEPTH,
    OPAQUE,
    TRANSPARENT,
    UNLIT,
    __SIZE
}

enum CB_LIGHT_MODE
{
    NONE,
    SIMPLE,
    ONE_SHADOW_MAP,
    DEFERRED,
}



__CbRenderInitialize();

function __CbRenderInitialize()
{
    static _initialized = false;
    if (_initialized) return;
    _initialized = true;
    
    __CbTrace("Welcome to Cardboard (Render) by @jujuadams! This is version " + __CB_RENDER_VERSION + ", " + __CB_RENDER_DATE);
    
    __CB_GLOBAL_RENDER
    if (debug_mode && (GM_build_type == "run")) global.__cardboardDebugRender = _global;
}