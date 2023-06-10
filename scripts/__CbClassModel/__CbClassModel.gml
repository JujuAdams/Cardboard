function __CbClassModel() constructor
{
    __CB_GLOBAL_BUILD
    
    __indexMax = 0;
    __array = [];
    
    static __AddBatch = function()
    {
        if (!is_array(__array)) return;
        
        with(_global.__batch)
        {
            //Don't do anything we know this batch is empty
            if (__texturePointer == undefined) return;
            
            //End the batch we have
            vertex_end(__vertexBuffer);
            
            array_push(other.__array, {
                vertexBuffer:   __vertexBuffer,
                texturePointer: __texturePointer,
            });
            
            //Clear the batch's texture state
            __texturePointer = undefined;
            __textureIndex   = undefined;
            
            //Then start the vertex buffer again!
            __vertexBuffer = vertex_create_buffer();
            vertex_begin(__vertexBuffer, __vertexFormat);
        }
    }
    
    static __Submit = function()
    {
        if (!is_array(__array)) return;
        
        var _i = 0;
        repeat(array_length(__array))
        {
            var _batch = __array[_i];
            vertex_submit(_batch.vertexBuffer, pr_trianglelist, _batch.texturePointer);
            ++_i;
        }
    }
    
    static __Destroy = function()
    {
        if (!is_array(__array)) return;
        
        var _i = 0;
        repeat(array_length(__array))
        {
            vertex_delete_buffer(__array[_i].vertexBuffer);
            ++_i;
        }
        
        __array = undefined;
    }
}