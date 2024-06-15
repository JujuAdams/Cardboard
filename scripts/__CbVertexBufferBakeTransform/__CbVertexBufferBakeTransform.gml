function __CbVertexBufferBakeTransform(_returnMode, _vertexBuffer, _vertexFormat, _zRotation = 0, _xScale = 1, _yScale = 1, _zScale = 1, _xOffset = 0, _yOffset = 0, _zOffset = 0)
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
    
    var _sin = dsin(-_zRotation);
    var _cos = dcos(-_zRotation);
    
    var _pos = 0;
    repeat(_vertexCount)
    {
        var _x = buffer_peek(_buffer, _pos + _positionOffset,     buffer_f32);
        var _y = buffer_peek(_buffer, _pos + _positionOffset + 4, buffer_f32);
        var _z = buffer_peek(_buffer, _pos + _positionOffset + 8, buffer_f32);
        
        var _x2 = _x*_cos - _y*_sin;
        var _y2 = _x*_sin + _y*_cos;
        
        _x = _x2*_xScale + _xOffset;
        _y = _y2*_xScale + _yOffset;
        _z =  _z*_xScale + _zOffset;
        
        buffer_poke(_buffer, _pos + _positionOffset,     buffer_f32, _x);
        buffer_poke(_buffer, _pos + _positionOffset + 4, buffer_f32, _y);
        buffer_poke(_buffer, _pos + _positionOffset + 8, buffer_f32, _z);
        
        if (_normalOffset != undefined)
        {
            var _x = buffer_peek(_buffer, _pos + _normalOffset,     buffer_f32);
            var _y = buffer_peek(_buffer, _pos + _normalOffset + 4, buffer_f32);
            
            var _x2 = _x*_cos - _y*_sin;
            var _y2 = _x*_sin + _y*_cos;
            
            buffer_poke(_buffer, _pos + _normalOffset,     buffer_f32, _x2);
            buffer_poke(_buffer, _pos + _normalOffset + 4, buffer_f32, _y2);
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