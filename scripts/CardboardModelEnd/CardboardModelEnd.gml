function CardboardModelEnd()
{
    if (!global.__cardboardModel) __CardboardError("No model has been created");
    global.__cardboardModel = false;
    
    //Don't do anything we know this batch is empty
    if (global.__cardboardBatchTexturePointer == undefined) return undefined;
    
    //Submit the batch we have
    vertex_end(global.__cardboardBatchVertexBuffer);
    
    var _model = {
        vertexBuffer:   global.__cardboardBatchVertexBuffer,
        texturePointer: global.__cardboardBatchTexturePointer,
    };
    
    vertex_delete_buffer(global.__cardboardBatchVertexBuffer);
    
    //Clear the batch's texture state
    global.__cardboardBatchTexturePointer = undefined;
    global.__cardboardBatchTextureIndex   = undefined;
    
    //Then start the vertex buffer again!
    global.__cardboardBatchVertexBuffer = vertex_create_buffer();
    vertex_begin(global.__cardboardBatchVertexBuffer, global.__cardboardVertexFormat);
    
    return _model;
}