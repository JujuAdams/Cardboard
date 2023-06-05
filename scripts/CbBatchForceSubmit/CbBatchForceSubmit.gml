/// Forces the current batch to be submitted to the GPU
/// 
/// This should be called before a change in GPU state (such as world matrix / shader changes etc.)

function CbBatchForceSubmit()
{
    __CB_GLOBAL_BUILD
    
    if (_global.__model != undefined) __CbError("Cannot force submit a batch whilst creating a model");
    
    with(_global.__batch)
    {
        //Don't do anything we know this batch is empty
        if (__texturePointer == undefined) return;
        
        //Submit the batch we have
        vertex_end(__vertexBuffer);
        vertex_submit(__vertexBuffer, pr_trianglelist, __texturePointer);
        vertex_delete_buffer(__vertexBuffer);
        
        //Clear the batch's texture state
        __texturePointer = undefined;
        __textureIndex   = undefined;
        
        //Then start the vertex buffer again!
        __vertexBuffer = vertex_create_buffer();
        vertex_begin(__vertexBuffer, __vertexFormat);
    }
}