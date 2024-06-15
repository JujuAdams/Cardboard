function __CbVertexBufferBakeTransformMatrix(_returnMode, _vertexBuffer, _vertexFormat, _matrix)
{
    var _buffer = buffer_create_from_vertex_buffer(_vertexBuffer, buffer_fixed, 1);
    var _info = vertex_format_get_info(_vertexFormat);
    
    var _stride = _info.stride;
    var _vertexCount = buffer_get_size(_buffer) / _stride;
    
    var _elementsArray = _info.elements;
    
    var _positionOffset = undefined;
    var _i = 0;
    repeat(array_length(_elementsArray))
    {
        var _elementStruct = _elementsArray[_i];
        if ((_elementStruct.usage == vertex_usage_position) && (_elementStruct.type == vertex_type_float3) && (_elementStruct.size == 12))
        {
            _positionOffset = _elementStruct.offset;
            break;
        }
        
        ++_i;
    }
    
    var _normalOffset = undefined;
    var _i = 0;
    repeat(array_length(_elementsArray))
    {
        var _elementStruct = _elementsArray[_i];
        if ((_elementStruct.usage == vertex_usage_normal) && (_elementStruct.type == vertex_type_float3) && (_elementStruct.size == 12))
        {
            _normalOffset = _elementStruct.offset;
            break;
        }
        
        ++_i;
    }
    
    var _pos = 0;
    repeat(_vertexCount)
    {
        var _x = buffer_peek(_buffer, _pos + _positionOffset,     buffer_f32);
        var _y = buffer_peek(_buffer, _pos + _positionOffset + 4, buffer_f32);
        var _z = buffer_peek(_buffer, _pos + _positionOffset + 8, buffer_f32);
        
        var _result = matrix_transform_vertex(_matrix, _x, _y, _z, 1);
        
        buffer_poke(_buffer, _pos + _positionOffset,     buffer_f32, _result[0]);
        buffer_poke(_buffer, _pos + _positionOffset + 4, buffer_f32, _result[1]);
        buffer_poke(_buffer, _pos + _positionOffset + 8, buffer_f32, _result[2]);
        
        if (_normalOffset != undefined)
        {
            var _x = buffer_peek(_buffer, _pos + _normalOffset,     buffer_f32);
            var _y = buffer_peek(_buffer, _pos + _normalOffset + 4, buffer_f32);
            var _z = buffer_peek(_buffer, _pos + _normalOffset + 8, buffer_f32);
            
            var _result = matrix_transform_vertex(_matrix, _x, _y, _z, 0);
            
            buffer_poke(_buffer, _pos + _normalOffset,     buffer_f32, _result[0]);
            buffer_poke(_buffer, _pos + _normalOffset + 4, buffer_f32, _result[1]);
            buffer_poke(_buffer, _pos + _normalOffset + 8, buffer_f32, _result[2]);
        }
        
        _pos += _stride;
    }
    
    if (_returnMode == 1)
    {
        var _return = vertex_create_buffer_from_buffer(_buffer, _vertexFormat);
        buffer_delete(_buffer);
        return _return;
    }
    else if (_returnMode == 2)
    {
        return _buffer;
    }
    else
    {
        vertex_update_buffer_from_buffer(_vertexBuffer, 0, _buffer);
        buffer_delete(_buffer);
        return undefined;
    }
}