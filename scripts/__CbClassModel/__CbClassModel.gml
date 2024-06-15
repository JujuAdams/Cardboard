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
    
    static __BakeTransform = function(_zRotation, _xScale, _yScale, _zScale, _xOffset, _yOffset, _zOffset)
    {
        var _vertexFormat = _global.__batch.__vertexFormat;
        
        var _i = 0;
        repeat(array_length(array))
        {
            __CbVertexBufferBakeTransform(0, array[_i].vertexBuffer, _vertexFormat, _zRotation, _xScale, _yScale, _zScale, _xOffset, _yOffset, _zOffset);
            ++_i;
        }
    }
    
    static __BakeTransformMatrix = function(_matrix)
    {
        var _vertexFormat = _global.__batch.__vertexFormat;
        
        var _i = 0;
        repeat(array_length(array))
        {
            __CbVertexBufferBakeTransformMatrix(0, array[_i].vertexBuffer, _vertexFormat, _matrix);
            ++_i;
        }
    }
    
    static __CopyWithTransform = function(_sourceModel, _zRotation, _xScale, _yScale, _zScale, _xOffset, _yOffset, _zOffset)
    {
        var _vertexFormat = _global.__batch.__vertexFormat;
        
        var _sourceArray = _sourceModel.array;
        var _i = 0;
        repeat(array_length(_sourceArray))
        {
            var _sourceVertexBuffer = _sourceArray[_i].vertexBuffer;
            var _texturePointer     = _sourceArray[_i].texturePointer;
            
            var _newVertexBuffer = __CbVertexBufferBakeTransform(1, _sourceVertexBuffer, _vertexFormat, _zRotation, _xScale, _yScale, _zScale, _xOffset, _yOffset, _zOffset);
            array_push(array, {
                vertexBuffer:   _newVertexBuffer,
                texturePointer: _texturePointer,
            });
            
            ++_i;
        }
    }
    
    static __CopyWithTransformMatrix = function(_sourceModel, _matrix)
    {
        var _vertexFormat = _global.__batch.__vertexFormat;
        
        var _sourceArray = _sourceModel.array;
        var _i = 0;
        repeat(array_length(_sourceArray))
        {
            var _sourceVertexBuffer = _sourceArray[_i].vertexBuffer;
            var _texturePointer     = _sourceArray[_i].texturePointer;
            
            var _newVertexBuffer = __CbVertexBufferBakeTransformMatrix(1, _sourceVertexBuffer, _vertexFormat, _matrix);
            array_push(array, {
                vertexBuffer:   _newVertexBuffer,
                texturePointer: _texturePointer,
            });
            
            ++_i;
        }
    }
}