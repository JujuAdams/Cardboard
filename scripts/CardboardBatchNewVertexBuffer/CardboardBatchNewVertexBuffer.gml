/// Starts a new vertex buffer inside Cardboard's batching system
/// 
/// This vertex buffer can be used to add your own vertex data to the batch
//
/// When CARDBOARD_WRITE_NORMALS is set to <false>, the vertex format is as follows:
///  - vertex_format_add_position_3d
///  - vertex_format_add_color
///  - vertex_format_add_texcoord
//
/// When CARDBOARD_WRITE_NORMALS is set to <true>, the vertex format is as follows:
///  - vertex_format_add_position_3d
///  - vertex_format_add_normal
///  - vertex_format_add_color
///  - vertex_format_add_texcoord
/// 
/// @param texture  The texture pointer to use with the new vertex buffer

function CardboardBatchNewVertexBuffer(_texture)
{
    __CARDBOARD_GLOBAL
    
    if (_global.__buildingModel) __CardboardError("Cannot use CardboardBatchNewVertexBuffer() whilst a model is being built\nUse CardboardModelNewVertexBuffer() to instead");
    
    CardboardBatchForceSubmit();
    
    _global.__batchTexturePointer = _texture;
    _global.__batchTextureIndex   = undefined;
    
    return _global.__batchVertexBuffer;
}