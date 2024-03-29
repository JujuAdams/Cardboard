/// Starts a new vertex buffer inside the model that's currently being built
/// 
/// This vertex buffer can be used to add your own vertex data to the model
/// Its vertex format is as follows:
///  - vertex_format_add_position_3d
///  - vertex_format_add_color
///  - vertex_format_add_texcoord
/// 
/// @param texture  The texture pointer to use with the new vertex buffer

function CardboardModelNewVertexBuffer(_texture)
{
    __CARDBOARD_GLOBAL
    
    if (!_global.__buildingModel) __CardboardError("Cannot use CardboardModelNewVertexBuffer() when a model is not being built\nUse CardboardBatchNewVertexBuffer() to instead");
    
    _global.__model.__AddBatch();
    
    _global.__batchTexturePointer = _texture;
    _global.__batchTextureIndex   = undefined;
    
    return _global.__batchVertexBuffer;
}