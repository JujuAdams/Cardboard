/// Draws a sprite perpendicular to the floor ("standing up") and facing the camera
/// 
/// This function requires that you call CardboardViewMatrixSet() before drawing the billboarded sprite
/// If auto-batching is turned on or you are building a model then the sprite may not be immediately drawn
/// 
/// N.B. Billboarded sprites that have been written into a model will use the camera position at the time
///      that the sprite is written into a model and may not necessarily follow the camera when the model
///      is drawn thereafter
///
/// @param sprite  Sprite to draw
/// @param image   Image of the sprite to draw
/// @param x       x-coordinate to draw the sprite at
/// @param y       y-coordinate to draw the sprite at
/// @param z       z-coordinate to draw the sprite at

function CardboardSpriteBillboard(_sprite, _image, _x, _y, _z)
{
    __CARDBOARD_GLOBAL
    __CARDBOARD_SPRITE_COMMON_TEXTURE
    __CARDBOARD_SPRITE_COMMON_UVS
    
    //Cache the vertex positions
    var _l = _imageData.left;
    var _t = _imageData.top;
    var _r = _imageData.right;
    var _b = _imageData.bottom;
    
    //Perform a simple 2D rotation
    var _sin = _global.__billboardYawSin;
    var _cos = _global.__billboardYawCos;
    
    var _lX =  _l*_cos + _x;
    var _lY =  _l*_sin + _y;
    var _rX =  _r*_cos + _x;
    var _rY =  _r*_sin + _y;
    var _tZ = -_t + _z;
    var _bZ = -_b + _z;
    
    //Add this sprite to the vertex buffer
    var _vertexBuffer = _global.__batchVertexBuffer;
    
    if (CARDBOARD_WRITE_NORMALS)
    {
        var _normalX = -_sin;
        var _normalY =  _cos;
        
        vertex_position_3d(_vertexBuffer, _lX, _lY, _tZ); vertex_normal(_vertexBuffer, _normalX, _normalY, 0); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, _u0, _v0);
        vertex_position_3d(_vertexBuffer, _lX, _lY, _bZ); vertex_normal(_vertexBuffer, _normalX, _normalY, 0); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, _u0, _v1);
        vertex_position_3d(_vertexBuffer, _rX, _rY, _tZ); vertex_normal(_vertexBuffer, _normalX, _normalY, 0); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, _u1, _v0);
        
        vertex_position_3d(_vertexBuffer, _rX, _rY, _tZ); vertex_normal(_vertexBuffer, _normalX, _normalY, 0); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, _u1, _v0);
        vertex_position_3d(_vertexBuffer, _lX, _lY, _bZ); vertex_normal(_vertexBuffer, _normalX, _normalY, 0); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, _u0, _v1);
        vertex_position_3d(_vertexBuffer, _rX, _rY, _bZ); vertex_normal(_vertexBuffer, _normalX, _normalY, 0); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, _u1, _v1);
    }
    else
    {
        vertex_position_3d(_vertexBuffer, _lX, _lY, _tZ); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, _u0, _v0);
        vertex_position_3d(_vertexBuffer, _lX, _lY, _bZ); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, _u0, _v1);
        vertex_position_3d(_vertexBuffer, _rX, _rY, _tZ); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, _u1, _v0);
        
        vertex_position_3d(_vertexBuffer, _rX, _rY, _tZ); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, _u1, _v0);
        vertex_position_3d(_vertexBuffer, _lX, _lY, _bZ); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, _u0, _v1);
        vertex_position_3d(_vertexBuffer, _rX, _rY, _bZ); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, _u1, _v1);
    }
    
    __CARDBOARD_FORCE_SUBMIT_CONDITION
}