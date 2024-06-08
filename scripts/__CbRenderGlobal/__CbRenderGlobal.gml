#macro __CB_GLOBAL_RENDER  static _global = __CbRenderGlobal();

function __CbRenderGlobal()
{
    static _struct = {
        __lightMode:         CB_LIGHT_MODE.DISABLE_LIGHTING,
        __alphaTestRef:      0.5,
        __surfaceWorkaround: false,
        __backfaceCulling:   true,
        
        __fog: {
            __enabled: false,
            __color:   c_black,
            __near:    500,
            __far:     1000,
        },
        
        __camera: {
            __orthographic: true,
            __axonometric:  true,
            __zTilt:        true,
            
            __width:  surface_get_width(application_surface),
            __height: surface_get_height(application_surface),
            
            __xFrom:   0,
            __yFrom: 128,
            __zFrom: 128,
            
            __xTo:   0,
            __yTo: 128,
            __zTo: 128,
            
            __xUp: 0,
            __yUp: 0,
            __zUp: 1,
            
            __near: -1024,
            __far:   1024,
            
            __fieldOfView: 90,
        },
        
        __billboardYawSetFunc: undefined,
        
        __lighting: {
            __lightStructArray: [],
            
            __ambient:     c_white,
            __posRadArray: array_create(4*__CB_LIGHT_COUNT, 0),
            __colorArray:  array_create(3*__CB_LIGHT_COUNT, 0),
            
            __defaultDepthFunction: undefined,
            
            __surfaceDepth:  -1,
            __surfaceNormal: -1,
            __surfaceLight:  -1,
        },
        
        __old: {
            __set:              false,
            __worldMatrix:      matrix_get(matrix_world),
            __viewMatrix:       matrix_get(matrix_view),
            __projectionMatrix: matrix_get(matrix_projection),
        },
    };
    
    return _struct;
}