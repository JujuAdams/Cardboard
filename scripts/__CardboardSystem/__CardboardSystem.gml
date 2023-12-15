#macro __CARDBOARD_VERSION     "1.2.1"
#macro __CARDBOARD_DATE        "2023-12-15"
#macro __CARDBOARD_MAX_IMAGES  1024



__CardboardInitialize();

function __CardboardInitialize()
{
    static _initialized = false;
    if (_initialized) return;
    _initialized = true;
    
    __CardboardTrace("Welcome to Cardboard by @jujuadams! This is version " + __CARDBOARD_VERSION + ", " + __CARDBOARD_DATE);
    
    __CARDBOARD_GLOBAL
    
    vertex_format_begin();
    vertex_format_add_position_3d(); //12 bytes
    vertex_format_add_color();       // 4 bytes
    vertex_format_add_texcoord();    // 8 bytes
    _global.__vertexFormat = vertex_format_end();
    
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
            
            _texturePageIndexMap[? __CARDBOARD_MAX_IMAGES*real(_sprite) + _image] = {
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
}



function __CardboardTrace()
{
    var _string = "Cardboard " + string(__CARDBOARD_VERSION) + ": ";
    
    var _i = 0
    repeat(argument_count)
    {
        if (is_real(argument[_i]))
        {
            _string += string_format(argument[_i], 0, 4);
        }
        else
        {
            _string += string(argument[_i]);
        }
        
        ++_i;
    }
    
    show_debug_message(_string);
}

function __CardboardError()
{
    var _string = "";
    
    var _i = 0
    repeat(argument_count)
    {
        _string += string(argument[_i]);
        ++_i;
    }
    
    show_debug_message("Cardboard " + string(__CARDBOARD_VERSION) + ": " + string_replace_all(_string, "\n", "\n          "));
    show_error("Cardboard " + string(__CARDBOARD_VERSION) + ":\n" + _string + "\n ", true);
}


