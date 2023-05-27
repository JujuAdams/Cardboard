function __CardboardClassModel() constructor
{
    __CARDBOARD_GLOBAL
    
    array = [];
    
    static __AddBatch = function()
    {
        if (!is_array(array)) return;
        
        //Don't do anything we know this batch is empty
        if (_global.__batchTexturePointer == undefined) return;
        
        //End the batch we have
        vertex_end(_global.__batchVertexBuffer);
        
        array_push(array, {
            vertexBuffer:   _global.__batchVertexBuffer,
            texturePointer: _global.__batchTexturePointer,
        });
        
        //Clear the batch's texture state
        _global.__batchTexturePointer = undefined;
        _global.__batchTextureIndex   = undefined;
        
        //Then start the vertex buffer again!
        _global.__batchVertexBuffer = vertex_create_buffer();
        vertex_begin(_global.__batchVertexBuffer, _global.__vertexFormat);
    }
    
    static __Submit = function()
    {
        if (!is_array(array)) return;
        
        var _i = 0;
        repeat(array_length(array))
        {
            var _batch = array[_i];
            vertex_submit(_batch.vertexBuffer, pr_trianglelist, _batch.texturePointer);
            ++_i;
        }
    }
    
    static __Destroy = function()
    {
        if (!is_array(array)) return;
        
        var _i = 0;
        repeat(array_length(array))
        {
            vertex_delete_buffer(array[_i].vertexBuffer);
            ++_i;
        }
        
        array = undefined;
    }
}