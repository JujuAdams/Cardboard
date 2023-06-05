/// Starts a new vertex buffer inside the model that's currently being built
/// 
/// This vertex buffer can be used to add your own vertex data to the model
/// Its vertex format is as follows:
///  - vertex_format_add_position_3d
///  - vertex_format_add_color
///  - vertex_format_add_texcoord
/// 
/// @param texture  The texture pointer to use with the new vertex buffer

function CbModelNewVertexBuffer(_texture)
{
    __CB_GLOBAL
    
    if (_global.__model == undefined) __CbError("Cannot use CbModelNewVertexBuffer() when a model is not being built\nUse CbBatchNewVertexBuffer() to instead");
    
    _global.__model.__AddBatch();
    
    with(_global.__batch)
    {
        __texturePointer = _texture;
        __textureIndex   = undefined;
        
        return __vertexBuffer;
    }
}