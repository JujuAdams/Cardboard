/// Starts a new vertex buffer inside Cardboard's batching system
/// 
/// This vertex buffer can be used to add your own vertex data to the batch
/// Its vertex format is as follows:
///  - vertex_format_add_position_3d
///  - vertex_format_add_color
///  - vertex_format_add_texcoord
/// 
/// @param texture  The texture pointer to use with the new vertex buffer

function CardboardBatchNewVertexBuffer(_texture)
{
    if (global.__cardboardBuildingModel) __CardboardError("Cannot use CardboardBatchNewVertexBuffer() whilst a model is being built\nUse CardboardModelNewVertexBuffer() to instead");
    
    CardboardBatchForceSubmit();
    
    global.__cardboardBatchTexturePointer = _texture;
    global.__cardboardBatchTextureIndex   = undefined;
    
    return global.__cardboardBatchVertexBuffer;
}