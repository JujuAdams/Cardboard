function __CbClassModel() constructor
{
    __CB_GLOBAL_BUILD
    
    array = [];
    
    static __AddBatch = function()
    {
        if (!is_array(array)) return;
        
        with(_global.__batch)
        {
            //Don't do anything we know this batch is empty
            if (__texturePointer == undefined) return;
            
            //End the batch we have
            vertex_end(__vertexBuffer);
            
            array_push(other.array, {
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
    
    static __AddVertexBuffer = function(_vertexBuffer, _texturePointer)
    {
        array_push(array, {
            vertexBuffer:   _vertexBuffer,
            texturePointer: _texturePointer,
        });
    }
    
    static __AppendVertexBuffer = function(_vertexBuffer, _texturePointer)
    {
        var _i = 0;
        repeat(array_length(array))
        {
            var _foundTexture = array[_i].texturePointer;
            if (_foundTexture == _texturePointer)
            {
                var _destinationVertexBuffer = array[_i].vertexBuffer;
                vertex_update_buffer_from_vertex(_destinationVertexBuffer, vertex_get_number(_destinationVertexBuffer), _vertexBuffer);
                return;
            }
            
            ++_i;
        }
        
        __AddVertexBuffer(_vertexBuffer, _texturePointer);
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