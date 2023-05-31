#macro __CB_GLOBAL  static _global = __CbGlobal();

function __CbGlobal()
{
    static _struct = {
        
        //System-wide values
        __doubleSided:  true,
        __lightMode:    CB_LIGHT_MODE.NONE,
        __alphaTestRef: 0.5,
        
        __camera: {
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
            
            __near: -2000,
            __far:   2000,
        },
        
        __pass: [
            { // CB_PASS.LIGHT_DEPTH
                __function: undefined,
            },
            { // CB_PASS.OPAQUE
                __function: undefined,
            },
            { // CB_PASS.TRANSPARENT
                __function: undefined,
            },
        ],
        
        __lighting: {
            __array: [],
            
            __ambient:     c_white,
            __posRadArray: array_create(4*__CB_LIGHT_COUNT, 0),
            __colorArray:  array_create(3*__CB_LIGHT_COUNT, 0),
        },
        
        __deferredSurfaceDiffuse: -1,
        __deferredSurfaceDepth:   -1,
        __deferredSurfaceNormal:  -1,
        
        __lightingShadowCurrent: undefined,
        __lightingShadowArray: [new __CbClassShadowMap(), new __CbClassShadowMap()],
        
        __oldRenderStateMatrixWorld:      matrix_get(matrix_world),
        __oldRenderStateMatrixView:       matrix_get(matrix_view),
        __oldRenderStateMatrixProjection: matrix_get(matrix_projection),
        __oldRenderStateResetSurface:     false,
        
        __billboardYaw:    undefined,
        __billboardYawSin: 0,
        __billboardYawCos: 0,
        
        __autoBatching:        false,
        __batchTexturePointer: undefined,
        __batchTextureIndex:   undefined,
        __batchVertexBuffer:   vertex_create_buffer(),
        __vertexFormat:        undefined,
        
        __texturePageIndexMap: ds_map_create(),
        
        __model:         undefined,
        __buildingModel: false,
    };
    
    return _struct;
}