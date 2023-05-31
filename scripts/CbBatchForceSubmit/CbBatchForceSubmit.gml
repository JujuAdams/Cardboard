/// Forces the current batch to be submitted to the GPU
/// 
/// This should be called before a change in GPU state (such as world matrix / shader changes etc.)

function CbBatchForceSubmit()
{
    __CB_GLOBAL
    
    with(_global)
    {
        if (__buildingModel) __CbError("Cannot force submit a batch whilst creating a model");
        
        //Don't do anything we know this batch is empty
        if (__batchTexturePointer == undefined) return;
        
        //Submit the batch we have
        vertex_end(__batchVertexBuffer);
        vertex_submit(__batchVertexBuffer, pr_trianglelist, __batchTexturePointer);
        vertex_delete_buffer(__batchVertexBuffer);
        
        //Clear the batch's texture state
        __batchTexturePointer = undefined;
        __batchTextureIndex   = undefined;
        
        //Then start the vertex buffer again!
        __batchVertexBuffer = vertex_create_buffer();
        vertex_begin(__batchVertexBuffer, __vertexFormat);
    }
}