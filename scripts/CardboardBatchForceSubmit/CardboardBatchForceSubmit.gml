/// Forces the current batch to be submitted to the GPU
/// 
/// This should be called before a change in GPU state (such as world matrix / shader changes etc.)

function CardboardBatchForceSubmit()
{
    if (global.__cardboardBuildingModel) __CardboardError("Cannot force submit a batch whilst creating a model");
    
    //Don't do anything we know this batch is empty
    if (global.__cardboardBatchTexturePointer == undefined) return;
    
    //Submit the batch we have
    vertex_end(global.__cardboardBatchVertexBuffer);
    vertex_submit(global.__cardboardBatchVertexBuffer, pr_trianglelist, global.__cardboardBatchTexturePointer);
    vertex_delete_buffer(global.__cardboardBatchVertexBuffer);
    
    //Clear the batch's texture state
    global.__cardboardBatchTexturePointer = undefined;
    global.__cardboardBatchTextureIndex   = undefined;
    
    //Then start the vertex buffer again!
    global.__cardboardBatchVertexBuffer = vertex_create_buffer();
    vertex_begin(global.__cardboardBatchVertexBuffer, global.__cardboardVertexFormat);
}