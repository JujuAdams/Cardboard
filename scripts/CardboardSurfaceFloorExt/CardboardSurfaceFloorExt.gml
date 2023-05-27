/// Draws a surface parallel to the floor ("lying down")
/// 
/// This function treats a z angle of 0 degrees as orienting the surface to a camera pointing in a "negative y" direction e.g. from (0, 200, 200) to (0, 0, 0)
/// If auto-batching is turned on or you are building a model then the surface may not be immediately drawn
/// 
/// @param surface      Surface to draw
/// @param x            x-coordinate to draw the surface at
/// @param y            y-coordinate to draw the surface at
/// @param z            z-coordinate to draw the surface at
/// @param xScale       Scale of the surface on the x-axis
/// @param yScale       Scale of the surface on the y-axis
/// @param zAngle       Rotation of the surface around the z-axis
/// @param color        Blend color for the surface (c_white is "no blending")
/// @param alpha        Blend alpha for the surface (0 being transparent and 1 being 100% opacity)
/// @param [xOrigin=0]  x-offset
/// @param [yOrigin=0]  y-offset

function CardboardSurfaceFloorExt(_surface, _x, _y, _z, _xScale, _yScale, _zAngle, _color, _alpha, _xOrigin = 0, _yOrigin = 0)
{
    __CARDBOARD_GLOBAL
    __CARDBOARD_SURFACE_COMMON_TEXTURE
    
    //Scale up the image
    var _l =     -_xScale*_xOrigin;
    var _t =     -_yScale*_yOrigin;
    var _r = _l + _xScale*surface_get_width(_surface);
    var _b = _t + _yScale*surface_get_height(_surface);
    
    //Perform a simple 2D rotation in the y-axis
    var _sin = dsin(-_zAngle);
    var _cos = dcos(-_zAngle);
    
    var _ltX = _x + _l*_cos - _t*_sin;
    var _ltY = _y + _l*_sin + _t*_cos;
    var _rtX = _x + _r*_cos - _t*_sin;
    var _rtY = _y + _r*_sin + _t*_cos;
    var _lbX = _x + _l*_cos - _b*_sin;
    var _lbY = _y + _l*_sin + _b*_cos;
    var _rbX = _x + _r*_cos - _b*_sin;
    var _rbY = _y + _r*_sin + _b*_cos;
    
    //Add this surface to the vertex buffer
    var _vertexBuffer = _global.__batchVertexBuffer;
    
    if (CARDBOARD_WRITE_NORMALS)
    {
        vertex_position_3d(_vertexBuffer, _ltX, _ltY, _z); vertex_normal(_vertexBuffer, 0, 0, 1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 0, 0);
        vertex_position_3d(_vertexBuffer, _lbX, _lbY, _z); vertex_normal(_vertexBuffer, 0, 0, 1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 0, 1);
        vertex_position_3d(_vertexBuffer, _rtX, _rtY, _z); vertex_normal(_vertexBuffer, 0, 0, 1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 1, 0);
        
        vertex_position_3d(_vertexBuffer, _rtX, _rtY, _z); vertex_normal(_vertexBuffer, 0, 0, 1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 1, 0);
        vertex_position_3d(_vertexBuffer, _lbX, _lbY, _z); vertex_normal(_vertexBuffer, 0, 0, 1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 0, 1);
        vertex_position_3d(_vertexBuffer, _rbX, _rbY, _z); vertex_normal(_vertexBuffer, 0, 0, 1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 1, 1);
    }
    else
    {
        vertex_position_3d(_vertexBuffer, _ltX, _ltY, _z); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 0, 0);
        vertex_position_3d(_vertexBuffer, _lbX, _lbY, _z); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 0, 1);
        vertex_position_3d(_vertexBuffer, _rtX, _rtY, _z); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 1, 0);
        
        vertex_position_3d(_vertexBuffer, _rtX, _rtY, _z); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 1, 0);
        vertex_position_3d(_vertexBuffer, _lbX, _lbY, _z); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 0, 1);
        vertex_position_3d(_vertexBuffer, _rbX, _rbY, _z); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 1, 1);
    }
    
    __CARDBOARD_FORCE_SUBMIT_CONDITION
}