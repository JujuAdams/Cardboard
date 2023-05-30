#macro __CARDBOARD_GLOBAL  static _global = __CardboardGlobal();

function __CardboardGlobal()
{
    static _struct = {
        __doubleSided: true,
        
        __lightingAmbience:    c_white,
        __lightingPosRadArray: array_create(4*__CARDBOARD_LIGHT_COUNT, 0),
        __lightingColorArray:  array_create(3*__CARDBOARD_LIGHT_COUNT, 0),
        
        __alphaTestRef: 128,
        
        __oldRenderStateMatrixWorld:      matrix_get(matrix_world),
        __oldRenderStateMatrixView:       matrix_get(matrix_view),
        __oldRenderStateMatrixProjection: matrix_get(matrix_projection),
        
        __oldMatrixView: matrix_get(matrix_view),
        
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