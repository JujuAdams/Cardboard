/// Draws the depth buffer for the given surface.
/// 
/// @param surface
/// @param left
/// @param top
/// @param [width]
/// @param [height]

function draw_surface_depth(_surface, _left, _top, _width = undefined, _height = undefined)
{
    static _reflectSurface = -1;
    
    var _sourceWidth  = surface_get_width( _surface);
    var _sourceHeight = surface_get_height(_surface);
    
    _width  = _width ?? _sourceWidth;
    _height = _height ?? _sourceHeight;
    
    if (surface_get_target() != _surface)
    {
        var _right  = _left + _width  - 1;
        var _bottom = _top  + _height - 1;
        
        draw_primitive_begin_texture(pr_trianglestrip, surface_get_texture_depth(_surface));
        draw_vertex_texture_color(_left,  _top,    0, 0, c_white, 1);
        draw_vertex_texture_color(_right, _top,    1, 0, c_white, 1);
        draw_vertex_texture_color(_left,  _bottom, 0, 1, c_white, 1);
        draw_vertex_texture_color(_right, _bottom, 1, 1, c_white, 1);
        draw_primitive_end();
    }
    else
    {
        if ((surface_get_width(_reflectSurface) < _sourceWidth) || (surface_get_height(_reflectSurface) < _sourceHeight))
        {
            surface_free(_reflectSurface);
        }
        
        if (not surface_exists(_reflectSurface))
        {
            _reflectSurface = surface_create(_sourceWidth, _sourceHeight);
        }
        
        surface_set_target(_reflectSurface);
            draw_primitive_begin_texture(pr_trianglestrip, surface_get_texture_depth(_surface));
            draw_vertex_texture_color(0,                           0,                            0, 0, c_white, 1);
            draw_vertex_texture_color(surface_get_width(_surface), 0,                            1, 0, c_white, 1);
            draw_vertex_texture_color(0,                           surface_get_height(_surface), 0, 1, c_white, 1);
            draw_vertex_texture_color(surface_get_width(_surface), surface_get_height(_surface), 1, 1, c_white, 1);
            draw_primitive_end();
        surface_reset_target();
        
        draw_surface_part_ext(_reflectSurface,
                              0, 0,
                              _sourceWidth, _sourceHeight,
                              _left, _top,
                              _width / _sourceWidth, _height / _sourceHeight,
                              c_white, 1);
    }
}