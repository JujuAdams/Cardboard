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
/// @param xScale  Scale of the sprite on the x-axis
/// @param zScale  Scale of the sprite on the z-axis
/// @param yAngle  Rotation of the sprite around the y-axis
/// @param color   Blend color for the sprite (c_white is "no blending")
/// @param alpha   Blend alpha for the sprite (0 being transparent and 1 being 100% opacity)

function CardboardSpriteBillboardExt(_sprite, _image, _x, _y, _z, _xScale, _zScale, _yAngle, _color, _alpha)
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
    var _l = _xScale*_imageData.left;
    var _t = _zScale*_imageData.top;
    var _r = _xScale*_imageData.right;
    var _b = _zScale*_imageData.bottom;
    
    //Perform a simple 2D rotation
    var _sin = dsin(-_yAngle);
    var _cos = dcos(-_yAngle);
    
    var _ltX0 =   _l*_cos - _t*_sin;
    var _ltZ  = -(_l*_sin + _t*_cos) + _z;
    var _rtX0 =   _r*_cos - _t*_sin;
    var _rtZ  = -(_r*_sin + _t*_cos) + _z;
    var _lbX0 =   _l*_cos - _b*_sin;
    var _lbZ  = -(_l*_sin + _b*_cos) + _z;
    var _rbX0 =   _r*_cos - _b*_sin;
    var _rbZ  = -(_r*_sin + _b*_cos) + _z;
    
    //Perform a less simple 2D rotation
    var _sin = _global.__billboardYawSin;
    var _cos = _global.__billboardYawCos;
    var _ltX = _ltX0*_cos + _x;
    var _ltY = _ltX0*_sin + _y;
    var _rtX = _rtX0*_cos + _x;
    var _rtY = _rtX0*_sin + _y;
    var _lbX = _lbX0*_cos + _x;
    var _lbY = _lbX0*_sin + _y;
    var _rbX = _rbX0*_cos + _x;
    var _rbY = _rbX0*_sin + _y;
    
    //Cache the UVs for speeeeeeeed
    var _u0 = _imageData.u0;
    var _v0 = _imageData.v0;
    var _u1 = _imageData.u1;
    var _v1 = _imageData.v1;
    
    //Add this sprite to the vertex buffer
    var _vertexBuffer = _global.__batchVertexBuffer;
    
    vertex_position_3d(_vertexBuffer, _ltX, _ltY, _ltZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v0);
    vertex_position_3d(_vertexBuffer, _rtX, _rtY, _rtZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0);
    vertex_position_3d(_vertexBuffer, _lbX, _lbY, _lbZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1);
    
    vertex_position_3d(_vertexBuffer, _rtX, _rtY, _rtZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0);
    vertex_position_3d(_vertexBuffer, _rbX, _rbY, _rbZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v1);
    vertex_position_3d(_vertexBuffer, _lbX, _lbY, _lbZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1);
    
    if (!_global.__autoBatching && !_global.__buildingModel) CardboardBatchForceSubmit();
}