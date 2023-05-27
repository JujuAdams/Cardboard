/// Draws a sprite surface to the floor ("standing up") and facing the camera
/// 
/// This function requires that you call CardboardViewMatrixSet() before drawing the billboarded surface
/// If auto-batching is turned on or you are building a model then the surface may not be immediately drawn
/// 
/// N.B. Billboarded surfaces that have been written into a model will use the camera position at the time
///      that the surface is written into a model and may not necessarily follow the camera when the model
///      is drawn thereafter
///
/// @param surface      Surface to draw
/// @param x            x-coordinate to draw the surface at
/// @param y            y-coordinate to draw the surface at
/// @param z            z-coordinate to draw the surface at
/// @param [xOrigin=0]  x-offset
/// @param [yOrigin=0]  y-offset

function CardboardSurfaceBillboard(_surface, _x, _y, _z, _xOrigin = 0, _yOrigin = 0)
{
    __CARDBOARD_GLOBAL
    __CARDBOARD_SURFACE_COMMON_TEXTURE
    
    //Cache the vertex positions
    var _l = _x - _xOrigin;
    var _t = _z + _yOrigin;
    var _r = _l + surface_get_width(_surface);
    var _b = _t - surface_get_height(_surface);
    
    //Perform a simple 2D rotation
    var _lX = _l*_global.__billboardYawCos + _x;
    var _lY = _l*_global.__billboardYawSin + _y;
    var _rX = _r*_global.__billboardYawCos + _x;
    var _rY = _r*_global.__billboardYawSin + _y;
    var _tZ = _t + _z;
    var _bZ = _b + _z;
    
    //Add this surface to the vertex buffer
    var _vertexBuffer = _global.__batchVertexBuffer;
    
    if (CARDBOARD_WRITE_NORMALS)
    {
        var _normalX = _global.__billboardYawSin;
        var _normalY = _global.__billboardYawCos;
        
        vertex_position_3d(_vertexBuffer, _lX, _lY, _tZ); vertex_normal(_vertexBuffer, _normalX, _normalY, 0); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, 0, 0);
        vertex_position_3d(_vertexBuffer, _rX, _rY, _tZ); vertex_normal(_vertexBuffer, _normalX, _normalY, 0); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, 1, 0);
        vertex_position_3d(_vertexBuffer, _lX, _lY, _bZ); vertex_normal(_vertexBuffer, _normalX, _normalY, 0); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, 0, 1);
        
        vertex_position_3d(_vertexBuffer, _rX, _rY, _tZ); vertex_normal(_vertexBuffer, _normalX, _normalY, 0); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, 1, 0);
        vertex_position_3d(_vertexBuffer, _rX, _rY, _bZ); vertex_normal(_vertexBuffer, _normalX, _normalY, 0); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, 1, 1);
        vertex_position_3d(_vertexBuffer, _lX, _lY, _bZ); vertex_normal(_vertexBuffer, _normalX, _normalY, 0); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, 0, 1);
    }
    else
    {
        vertex_position_3d(_vertexBuffer, _lX, _lY, _tZ); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, 0, 0);
        vertex_position_3d(_vertexBuffer, _rX, _rY, _tZ); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, 1, 0);
        vertex_position_3d(_vertexBuffer, _lX, _lY, _bZ); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, 0, 1);
        
        vertex_position_3d(_vertexBuffer, _rX, _rY, _tZ); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, 1, 0);
        vertex_position_3d(_vertexBuffer, _rX, _rY, _bZ); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, 1, 1);
        vertex_position_3d(_vertexBuffer, _lX, _lY, _bZ); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, 0, 1);
    }
    
    __CARDBOARD_FORCE_SUBMIT_CONDITION
}