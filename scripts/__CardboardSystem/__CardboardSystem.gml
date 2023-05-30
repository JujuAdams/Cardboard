#macro __CARDBOARD_VERSION     "2.0.0"
#macro __CARDBOARD_DATE        "2023-05-30"
#macro __CARDBOARD_MAX_IMAGES  1024
#macro __CARDBOARD_Z_NEAR      -3000
#macro __CARDBOARD_Z_FAR       3000

#macro __CARDBOARD_LIGHT_COUNT   4
#macro __CARDBOARD_SHADOW_COUNT  2



__CardboardInitialize();

function __CardboardInitialize()
{
    static _initialized = false;
    if (_initialized) return;
    _initialized = true;
    
    __CardboardTrace("Welcome to Cardboard by @jujuadams! This is version " + __CARDBOARD_VERSION + ", " + __CARDBOARD_DATE);
    
    __CARDBOARD_GLOBAL
    
    if (CARDBOARD_WRITE_NORMALS)
    {
        vertex_format_begin();
        vertex_format_add_position_3d(); //12 bytes
        vertex_format_add_normal();      //12 bytes
        vertex_format_add_color();       // 4 bytes
        vertex_format_add_texcoord();    // 8 bytes
        _global.__vertexFormat = vertex_format_end();
    }
    else
    {
        vertex_format_begin();
        vertex_format_add_position_3d(); //12 bytes
        vertex_format_add_color();       // 4 bytes
        vertex_format_add_texcoord();    // 8 bytes
        _global.__vertexFormat = vertex_format_end();
    }
    
    vertex_begin(_global.__batchVertexBuffer, _global.__vertexFormat);
    
    //Cache texture page index information for every image of every sprite
    var _texturePageIndexMap = _global.__texturePageIndexMap;
    var _sprite = 0;
    while(sprite_exists(_sprite))
    {
        var _framesArray = sprite_get_info(_sprite).frames;
        
        var _number = sprite_get_number(_sprite);
        if (_number > __CARDBOARD_MAX_IMAGES) __CardboardError("Image number cannot exceed ", __CARDBOARD_MAX_IMAGES, " (", sprite_get_name(_sprite), ")");
        
        var _image = 0;
        repeat(_number)
        {
            var _uvs = sprite_get_uvs(_sprite, _image);
            
            var _left   = -sprite_get_xoffset(_sprite) + _uvs[4];
            var _top    = -sprite_get_yoffset(_sprite) + _uvs[5];
            var _right  = _left + _uvs[6]*sprite_get_width(_sprite);
            var _bottom = _top + _uvs[7]*sprite_get_height(_sprite);
            
            _texturePageIndexMap[? __CARDBOARD_MAX_IMAGES*_sprite + _image] = {
                spriteName: sprite_get_name(_sprite),
                image:      _image,
                
                texturePointer: sprite_get_texture(_sprite, _image),
                textureIndex:   _framesArray[_image].texture,
                
                left:   _left,
                top:    _top,
                right:  _right,
                bottom: _bottom,
                
                u0: _uvs[0],
                v0: _uvs[1],
                u1: _uvs[2],
                v1: _uvs[3],
            };
            
            ++_image;
        }
        
        ++_sprite;
    }
    
    time_source_start(time_source_create(time_source_global, 1, time_source_units_frames, __CardboardTick, [], -1));
}