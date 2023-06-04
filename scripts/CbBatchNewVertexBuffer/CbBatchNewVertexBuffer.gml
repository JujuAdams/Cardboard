/// Starts a new vertex buffer inside Cb's batching system
/// 
/// This vertex buffer can be used to add your own vertex data to the batch
//
/// When CB_WRITE_NORMALS is set to <false>, the vertex format is as follows:
///  - vertex_format_add_position_3d
///  - vertex_format_add_color
///  - vertex_format_add_texcoord
//
/// When CB_WRITE_NORMALS is set to <true>, the vertex format is as follows:
///  - vertex_format_add_position_3d
///  - vertex_format_add_normal
///  - vertex_format_add_color
///  - vertex_format_add_texcoord
/// 
/// @param texture  The texture pointer to use with the new vertex buffer

function CbBatchNewVertexBuffer(_texture)
{
    __CB_GLOBAL
    
    if (_global.__buildingModel) __CbError("Cannot use CbBatchNewVertexBuffer() whilst a model is being built\nUse CbModelNewVertexBuffer() to instead");
    
    //If we've got a pending batch then submit that before resetting draw state
    CbBatchForceSubmit();
    
    _global.__batchTexturePointer = _texture;
    _global.__batchTextureIndex   = undefined;
    
    return _global.__batchVertexBuffer;
}