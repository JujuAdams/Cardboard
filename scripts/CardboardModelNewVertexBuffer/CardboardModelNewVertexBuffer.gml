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
    if (!global.__cardboardBuildingModel) __CardboardError("Cannot use CardboardModelNewVertexBuffer() when a model is not being built\nUse CardboardBatchNewVertexBuffer() to instead");
    
    global.__cardboardModel.__AddBatch();
    
    global.__cardboardBatchTexturePointer = _texture;
    global.__cardboardBatchTextureIndex   = undefined;
    
    return global.__cardboardBatchVertexBuffer;
}