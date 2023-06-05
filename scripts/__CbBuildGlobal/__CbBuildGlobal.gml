#macro __CB_GLOBAL_BUILD  static _global = __CbBuildGlobal();

function __CbBuildGlobal()
{
    static _struct = {
        __doubleSided:         true,
        __vertexFormat:        undefined,
        __texturePageIndexMap: ds_map_create(),
        __model:               undefined,
        
        __tilesetDict: {},
        
        __billboard: {
            __yaw:    undefined,
            __yawSin: 0,
            __yawCos: 0,
        },
        
        __batch: {
            __auto:           false,
            __texturePointer: undefined,
            __textureIndex:   undefined,
            __vertexBuffer:   vertex_create_buffer(),
        },
    };
    
    return _struct;
}