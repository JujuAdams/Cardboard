/// Draws a surface stretched over an arbitrary quadrilateral
/// 
/// If auto-batching is turned on or you are building a model then the surface may not be immediately drawn
/// 
/// @param surface  Surface to draw
/// @param x1       x-coordinate for the top-left corner of the texture
/// @param y1       y-coordinate for the top-left corner of the texture
/// @param z1       z-coordinate for the top-left corner of the texture
/// @param x2       x-coordinate for the top-right corner of the texture
/// @param y2       y-coordinate for the top-right corner of the texture
/// @param z2       z-coordinate for the top-right corner of the texture
/// @param x3       x-coordinate for the bottom-left corner of the texture
/// @param y3       y-coordinate for the bottom-left corner of the texture
/// @param z3       z-coordinate for the bottom-left corner of the texture
/// @param x4       x-coordinate for the bottom-right corner of the texture
/// @param y4       y-coordinate for the bottom-right corner of the texture
/// @param z4       z-coordinate for the bottom-right corner of the texture
/// @param color    Blend color for the surface (c_white is "no blending")
/// @param alpha    Blend alpha for the surface (0 being transparent and 1 being 100% opacity)

function CardboardSurfaceQuad(_sprite, _image, _x1, _y1, _z1, _x2, _y2, _z2, _x3, _y3, _z3, _x4, _y4, _z4, _color, _alpha)
{
    __CARDBOARD_GLOBAL
    __CARDBOARD_SURFACE_COMMON_TEXTURE
    
    //Add this sprite to the vertex buffer
    var _vertexBuffer = _global.__batchVertexBuffer;
    
    if (CARDBOARD_WRITE_NORMALS)
    {
        //Cross product
        var _normalX = (_y2 - _y1)*(_z3 - _z1) - (_z2 - _z1)*(_y3 - _y1);
        var _normalY = (_z2 - _z1)*(_x3 - _x1) - (_x2 - _x1)*(_z3 - _z1);
        var _normalZ = (_x2 - _x1)*(_y3 - _y1) - (_y2 - _y1)*(_x3 - _x1);
        
        if (_global.__doubleSided)
        {
            var _invLength = 1 / point_distance_3d(0, 0, 0, _normalX, _normalY, _normalZ);
            _normalX *= _invLength;
            _normalY *= _invLength;
            _normalZ *= _invLength;
            
            var _dX = CARDBOARD_DOUBLE_SIDED_SPACING*_normalX;
            var _dY = CARDBOARD_DOUBLE_SIDED_SPACING*_normalY;
            var _dZ = CARDBOARD_DOUBLE_SIDED_SPACING*_normalZ;
            
            vertex_position_3d(_vertexBuffer, _x1 + _dX, _y1 + _dY, _z1 + _dZ); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 0, 0);
            vertex_position_3d(_vertexBuffer, _x3 + _dX, _y3 + _dY, _z3 + _dZ); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 0, 1);
            vertex_position_3d(_vertexBuffer, _x2 + _dX, _y2 + _dY, _z2 + _dZ); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 1, 0);
            
            vertex_position_3d(_vertexBuffer, _x2 + _dX, _y2 + _dY, _z2 + _dZ); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 1, 0);
            vertex_position_3d(_vertexBuffer, _x3 + _dX, _y3 + _dY, _z3 + _dZ); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 0, 1);
            vertex_position_3d(_vertexBuffer, _x4 + _dX, _y4 + _dY, _z4 + _dZ); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 1, 1);
            
            vertex_position_3d(_vertexBuffer, _x1 - _dX, _y1 - _dY, _z1 - _dZ); vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 0, 0);
            vertex_position_3d(_vertexBuffer, _x2 - _dX, _y2 - _dY, _z2 - _dZ); vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 1, 0);
            vertex_position_3d(_vertexBuffer, _x3 - _dX, _y3 - _dY, _z3 - _dZ); vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 0, 1);
            
            vertex_position_3d(_vertexBuffer, _x2 - _dX, _y2 - _dY, _z2 - _dZ); vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 1, 0);
            vertex_position_3d(_vertexBuffer, _x4 - _dX, _y4 - _dY, _z4 - _dZ); vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 1, 1);
            vertex_position_3d(_vertexBuffer, _x3 - _dX, _y3 - _dY, _z3 - _dZ); vertex_normal(_vertexBuffer, -_normalX, -_normalY, -_normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 0, 1);
        }
        else
        {
            vertex_position_3d(_vertexBuffer, _x1, _y1, _z1); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 0, 0);
            vertex_position_3d(_vertexBuffer, _x3, _y3, _z3); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 0, 1);
            vertex_position_3d(_vertexBuffer, _x2, _y2, _z2); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 1, 0);
            
            vertex_position_3d(_vertexBuffer, _x2, _y2, _z2); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 1, 0);
            vertex_position_3d(_vertexBuffer, _x3, _y3, _z3); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 0, 1);
            vertex_position_3d(_vertexBuffer, _x4, _y4, _z4); vertex_normal(_vertexBuffer, _normalX, _normalY, _normalZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 1, 1);
        }
    }
    else
    {
        vertex_position_3d(_vertexBuffer, _x1, _y1, _z1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 0, 0);
        vertex_position_3d(_vertexBuffer, _x3, _y3, _z3); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 0, 1);
        vertex_position_3d(_vertexBuffer, _x2, _y2, _z2); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 1, 0);
        
        vertex_position_3d(_vertexBuffer, _x2, _y2, _z2); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 1, 0);
        vertex_position_3d(_vertexBuffer, _x3, _y3, _z3); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 0, 1);
        vertex_position_3d(_vertexBuffer, _x4, _y4, _z4); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 1, 1);
    }
    
    __CARDBOARD_FORCE_SUBMIT_CONDITION
}