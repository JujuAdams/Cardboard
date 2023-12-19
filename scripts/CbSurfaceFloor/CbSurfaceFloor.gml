/// Draws a surface parallel to the floor ("lying down")
/// 
/// This function presumes that the camera is pointing in a "negative y" direction e.g. from (0, 200, 200) to (0, 0, 0)
/// If auto-batching is turned on or you are building a model then the surface may not be immediately drawn
/// 
/// @param surface      Surface to draw
/// @param x            x-coordinate to draw the surface at
/// @param y            y-coordinate to draw the surface at
/// @param z            z-coordinate to draw the surface at
/// @param [xOrigin=0]  x-offset
/// @param [yOrigin=0]  y-offset

function CbSurfaceFloor(_surface, _x, _y, _z, _xOrigin = 0, _yOrigin = 0)
{
    __CB_GLOBAL_BUILD
    __CB_SURFACE_COMMON_TEXTURE
    
    //Cache the vertex positions
    var _l = _x - _xOrigin;
    var _t = _y + _yOrigin;
    var _r = _l + surface_get_width(_surface);
    var _b = _t + surface_get_height(_surface);
    
    //Add this surface to the vertex buffer
    var _vertexBuffer = _global.__batch.__vertexBuffer;
    
    if (_global.__doubleSided)
    {
        vertex_position_3d(_vertexBuffer, _l, _t, _z + CB_DOUBLE_SIDED_SPACING); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0,  1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
        vertex_position_3d(_vertexBuffer, _l, _b, _z + CB_DOUBLE_SIDED_SPACING); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0,  1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, 0, 1);
        vertex_position_3d(_vertexBuffer, _r, _t, _z + CB_DOUBLE_SIDED_SPACING); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0,  1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, 1, 0);
        
        vertex_position_3d(_vertexBuffer, _r, _t, _z + CB_DOUBLE_SIDED_SPACING); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0,  1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, 1, 0);
        vertex_position_3d(_vertexBuffer, _l, _b, _z + CB_DOUBLE_SIDED_SPACING); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0,  1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, 0, 1);
        vertex_position_3d(_vertexBuffer, _r, _b, _z + CB_DOUBLE_SIDED_SPACING); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0,  1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, 1, 1);
        
        vertex_position_3d(_vertexBuffer, _l, _t, _z - CB_DOUBLE_SIDED_SPACING); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, -1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
        vertex_position_3d(_vertexBuffer, _r, _t, _z - CB_DOUBLE_SIDED_SPACING); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, -1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, 1, 0);
        vertex_position_3d(_vertexBuffer, _l, _b, _z - CB_DOUBLE_SIDED_SPACING); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, -1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, 0, 1);
        
        vertex_position_3d(_vertexBuffer, _r, _t, _z - CB_DOUBLE_SIDED_SPACING); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, -1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, 1, 0);
        vertex_position_3d(_vertexBuffer, _r, _b, _z - CB_DOUBLE_SIDED_SPACING); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, -1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, 1, 1);
        vertex_position_3d(_vertexBuffer, _l, _b, _z - CB_DOUBLE_SIDED_SPACING); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, -1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, 0, 1);
    }
    else
    {
        vertex_position_3d(_vertexBuffer, _l, _t, _z); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, 1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, 0, 0);
        vertex_position_3d(_vertexBuffer, _l, _b, _z); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, 1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, 0, 1);
        vertex_position_3d(_vertexBuffer, _r, _t, _z); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, 1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, 1, 0);
                                                                                                                                                                                                  
        vertex_position_3d(_vertexBuffer, _r, _t, _z); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, 1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, 1, 0);
        vertex_position_3d(_vertexBuffer, _l, _b, _z); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, 1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, 0, 1);
        vertex_position_3d(_vertexBuffer, _r, _b, _z); if (CB_WRITE_NORMALS) { vertex_normal(_vertexBuffer, 0, 0, 1); } vertex_color(_vertexBuffer, c_white, 1.0); vertex_texcoord(_vertexBuffer, 1, 1);
    }
    
    __CB_CONDITIONAL_SUBMIT
}