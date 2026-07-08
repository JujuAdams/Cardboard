/// @param sprite
/// @param image
/// @param depth
/// @param [scale=1]
/// @param [alphaThreshold=0.5]

function ConvertSpriteStack(_sprite, _image, _depth, _scale = 1, _alphaThreshold = 0.5)
{
    __CB_GLOBAL_BUILD
    static _vertexFormat = _global.__batch.__vertexFormat;
    
    static _buffer = buffer_create(1024, buffer_grow, 1);
    static _surface = -1;
    
    var _totalWidth = sprite_get_width(_sprite);
    var _width  = floor(_totalWidth / _depth);
    var _height = sprite_get_height(_sprite);
    
    if (surface_exists(_surface) && ((surface_get_width(_surface) != _totalWidth) || (surface_get_height(_surface) != _height)))
    {
        surface_free(_surface);
    }
    
    if (not surface_exists(_surface))
    {
        _surface = surface_create(_totalWidth, _height);
    }
    
    buffer_resize(_buffer, 4*_totalWidth*_height);
    
    surface_set_target(_surface);
    draw_clear_alpha(c_black, 0);
    
    var _oldAlphaTestEnabled = gpu_get_alphatestenable();
    var _oldAlphaTestRef     = gpu_get_alphatestref();
    gpu_set_alphatestenable(true);
    gpu_set_alphatestref(_alphaThreshold);
    gpu_set_blendmode_ext(bm_one, bm_zero);
    
    draw_sprite(_sprite, _image, sprite_get_xoffset(_sprite), sprite_get_yoffset(_sprite));
    
    gpu_set_alphatestenable(_oldAlphaTestEnabled);
    gpu_set_alphatestref(_oldAlphaTestRef);
    gpu_set_blendmode(bm_normal);
    
    surface_reset_target();
    
    buffer_get_surface(_buffer, _surface, 0);
    
    var _vertexBuffer = vertex_create_buffer();
    vertex_begin(_vertexBuffer, _vertexFormat);
    
    var _worldZ = 0;
    var _z = 0;
    repeat(_depth)
    {
        var _worldY = 0;
        var _y = 0;
        repeat(_height)
        {
            var _worldX = 0;
            var _x = 0;
            repeat(_width)
            {
                var _color = buffer_peek(_buffer, 4*(_x + _totalWidth*_y + _width*_z), buffer_u32);
                if (_color & 0xFF_000000)
                {
                    _color &= 0xFFFFFF;
                    
                    if ((_x > 0) || (not buffer_peek(_buffer, 4*((_x-1) + _totalWidth*_y + _width*_z), buffer_u32)))
                    {
                        vertex_position_3d(_vertexBuffer, _worldX, _worldY,        _worldZ       ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, -1, 0, 0); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        vertex_position_3d(_vertexBuffer, _worldX, _worldY+_scale, _worldZ       ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, -1, 0, 0); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        vertex_position_3d(_vertexBuffer, _worldX, _worldY,        _worldZ+_scale); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, -1, 0, 0); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        
                        vertex_position_3d(_vertexBuffer, _worldX, _worldY,        _worldZ+_scale); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, -1, 0, 0); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        vertex_position_3d(_vertexBuffer, _worldX, _worldY+_scale, _worldZ       ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, -1, 0, 0); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        vertex_position_3d(_vertexBuffer, _worldX, _worldY+_scale, _worldZ+_scale); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, -1, 0, 0); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                    }
                    
                    if ((_x < _width-1) || (not buffer_peek(_buffer, 4*((_x+1) + _totalWidth*_y + _width*_z), buffer_u32)))
                    {
                        vertex_position_3d(_vertexBuffer, _worldX+_scale, _worldY,        _worldZ       ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 1, 0, 0); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        vertex_position_3d(_vertexBuffer, _worldX+_scale, _worldY,        _worldZ+_scale); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 1, 0, 0); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        vertex_position_3d(_vertexBuffer, _worldX+_scale, _worldY+_scale, _worldZ       ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 1, 0, 0); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        
                        vertex_position_3d(_vertexBuffer, _worldX+_scale, _worldY+_scale, _worldZ       ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 1, 0, 0); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        vertex_position_3d(_vertexBuffer, _worldX+_scale, _worldY,        _worldZ+_scale); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 1, 0, 0); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        vertex_position_3d(_vertexBuffer, _worldX+_scale, _worldY+_scale, _worldZ+_scale); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 1, 0, 0); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                    }
                    
                    if ((_y > 0) || (not buffer_peek(_buffer, 4*(_x + _totalWidth*(_y-1) + _width*_z), buffer_u32)))
                    {
                        vertex_position_3d(_vertexBuffer, _worldX,        _worldY, _worldZ       ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, -1, 0); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        vertex_position_3d(_vertexBuffer, _worldX,        _worldY, _worldZ+_scale); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, -1, 0); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        vertex_position_3d(_vertexBuffer, _worldX+_scale, _worldY, _worldZ       ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, -1, 0); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        
                        vertex_position_3d(_vertexBuffer, _worldX+_scale, _worldY, _worldZ       ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, -1, 0); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        vertex_position_3d(_vertexBuffer, _worldX,        _worldY, _worldZ+_scale); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, -1, 0); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        vertex_position_3d(_vertexBuffer, _worldX+_scale, _worldY, _worldZ+_scale); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, -1, 0); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                    }
                    
                    if ((_y < _height-1) || (not buffer_peek(_buffer, 4*(_x + _totalWidth*(_y+1) + _width*_z), buffer_u32)))
                    {
                        vertex_position_3d(_vertexBuffer, _worldX,        _worldY+_scale, _worldZ       ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 1, 0); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        vertex_position_3d(_vertexBuffer, _worldX+_scale, _worldY+_scale, _worldZ       ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 1, 0); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        vertex_position_3d(_vertexBuffer, _worldX,        _worldY+_scale, _worldZ+_scale); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 1, 0); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        
                        vertex_position_3d(_vertexBuffer, _worldX,        _worldY+_scale, _worldZ+_scale); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 1, 0); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        vertex_position_3d(_vertexBuffer, _worldX+_scale, _worldY+_scale, _worldZ       ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 1, 0); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        vertex_position_3d(_vertexBuffer, _worldX+_scale, _worldY+_scale, _worldZ+_scale); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 1, 0); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                    }
                    
                    if ((_z > 0) || (not buffer_peek(_buffer, 4*(_x + _totalWidth*_y + _width*(_z-1)), buffer_u32)))
                    {
                        vertex_position_3d(_vertexBuffer, _worldX,        _worldY,        _worldZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, -1); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        vertex_position_3d(_vertexBuffer, _worldX,        _worldY+_scale, _worldZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, -1); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        vertex_position_3d(_vertexBuffer, _worldX+_scale, _worldY,        _worldZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, -1); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        
                        vertex_position_3d(_vertexBuffer, _worldX+_scale, _worldY,        _worldZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, -1); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        vertex_position_3d(_vertexBuffer, _worldX,        _worldY+_scale, _worldZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, -1); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        vertex_position_3d(_vertexBuffer, _worldX+_scale, _worldY+_scale, _worldZ); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, -1); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                    }
                    
                    if ((_z < _depth-1) || (not buffer_peek(_buffer, 4*(_x + _totalWidth*_y + _width*(_z+1)), buffer_u32)))
                    {
                        vertex_position_3d(_vertexBuffer, _worldX,        _worldY,        _worldZ+_scale); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, 1); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        vertex_position_3d(_vertexBuffer, _worldX,        _worldY+_scale, _worldZ+_scale); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, 1); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        vertex_position_3d(_vertexBuffer, _worldX+_scale, _worldY,        _worldZ+_scale); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, 1); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        
                        vertex_position_3d(_vertexBuffer, _worldX+_scale, _worldY,        _worldZ+_scale); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, 1); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        vertex_position_3d(_vertexBuffer, _worldX,        _worldY+_scale, _worldZ+_scale); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, 1); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                        vertex_position_3d(_vertexBuffer, _worldX+_scale, _worldY+_scale, _worldZ+_scale); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, 1); } vertex_color(_vertexBuffer, _color, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
                    }
                }
                
                ++_x;
                _worldX += _scale;
            }
            
            ++_y;
            _worldY += _scale;
        }
        
        ++_z;
        _worldZ += _scale;
    }
    
    vertex_end(_vertexBuffer);
    vertex_freeze(_vertexBuffer);
    
    var _model = new __CbClassModel();
    _model.__AddVertexBuffer(_vertexBuffer, sprite_get_texture(sPixel, 0));
    
    return _model;
}