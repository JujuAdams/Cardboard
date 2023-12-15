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
    
    var _flooredImage = floor(max(0, _image)) mod sprite_get_number(_sprite);
    var _imageData = _global.__texturePageIndexMap[? __CARDBOARD_MAX_IMAGES*real(_sprite) + _flooredImage];
    
    //Break the batch if we've swapped texture
    if (_imageData.textureIndex != _global.__batchTextureIndex)
    {
        __CardboardBatchComplete();
        
        _global.__batchTexturePointer = _imageData.texturePointer;
        _global.__batchTextureIndex   = _imageData.textureIndex;
    }
    
    //Scale up the image
    var _l = _imageData.left;
    var _t = _imageData.top;
    var _r = _imageData.right;
    var _b = _imageData.bottom;
    
    //Perform a simple 2D rotation
    var _lX =  _l*_global.__billboardYawCos + _x;
    var _lY =  _l*_global.__billboardYawSin + _y;
    var _rX =  _r*_global.__billboardYawCos + _x;
    var _rY =  _r*_global.__billboardYawSin + _y;
    var _tZ = -_t + _z;
    var _bZ = -_b + _z;
    
    //Cache the UVs for speeeeeeeed
    var _u0 = _imageData.u0;
    var _v0 = _imageData.v0;
    var _u1 = _imageData.u1;
    var _v1 = _imageData.v1;
    
    //Add this sprite to the vertex buffer
    var _vertexBuffer = _global.__batchVertexBuffer;
    
    vertex_position_3d(_vertexBuffer, _lX, _lY, _tZ); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, _u0, _v0);
    vertex_position_3d(_vertexBuffer, _rX, _rY, _tZ); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, _u1, _v0);
    vertex_position_3d(_vertexBuffer, _lX, _lY, _bZ); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, _u0, _v1);
    
    vertex_position_3d(_vertexBuffer, _rX, _rY, _tZ); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, _u1, _v0);
    vertex_position_3d(_vertexBuffer, _rX, _rY, _bZ); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, _u1, _v1);
    vertex_position_3d(_vertexBuffer, _lX, _lY, _bZ); vertex_color(_vertexBuffer, c_white, 1); vertex_texcoord(_vertexBuffer, _u0, _v1);
    
    if (!_global.__autoBatching && !_global.__buildingModel) CardboardBatchForceSubmit();
}