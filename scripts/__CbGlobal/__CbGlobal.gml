#macro __CB_GLOBAL  static _global = __CbGlobal();

function __CbGlobal()
{
    static _struct = {
        
        //System-wide values
        __doubleSided:  true,
        __lightMode:    CB_LIGHT_MODE.NONE,
        __alphaTestRef: 0.5,
        
        __fog: {
            __enabled: false,
            __color:   c_black,
            __near:    500,
            __far:     1000,
        },
        
        __camera: {
            __orthographic: true,
            
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
            
            __axonometric: true,
            
            __near: -2048,
            __far:   2048,
            
            __fieldOfView: 90,
        },
        
        __lighting: {
            __array: [],
            
            __ambient:     c_white,
            __posRadArray: array_create(4*__CB_LIGHT_COUNT, 0),
            __colorArray:  array_create(3*__CB_LIGHT_COUNT, 0),
            
            __defaultDepthFunction: undefined,
            
            __surfaceDepth:  -1,
            __surfaceNormal: -1,
            __surfaceLight:  -1,
        },
        
        __billboard: {
            __yaw:    undefined,
            __yawSin: 0,
            __yawCos: 0,
        },
        
        __oldRenderState: {
            __set:              false,
            __worldMatrix:      matrix_get(matrix_world),
            __viewMatrix:       matrix_get(matrix_view),
            __projectionMatrix: matrix_get(matrix_projection),
        },
        
        __surfaceWorkaround: false,
        
        __batch: {
            __auto:           false,
            __texturePointer: undefined,
            __textureIndex:   undefined,
            __vertexBuffer:   vertex_create_buffer(),
        },
        
        __vertexFormat: undefined,
        
        __texturePageIndexMap: ds_map_create(),
        
        __model: undefined,
        
        __tilesetDict: {},
    };
    
    return _struct;
}