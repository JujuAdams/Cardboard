#macro __CARDBOARD_GLOBAL  static _global = __CardboardGlobal();

function __CardboardGlobal()
{
    static _struct = {
        __lighting: {
            __started:       false,
            __surfaceWidth:  1920,
            __surfaceHeight: 1080,
        },
        
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