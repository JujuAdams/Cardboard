/// Draws a sprite parallel to the floor ("lying down")
/// 
/// This function treats a z angle of 0 degrees as orienting the sprite to a camera pointing in a "negative y" direction e.g. from (0, 200, 200) to (0, 0, 0)
/// If auto-batching is turned on or you are building a model then the sprite may not be immediately drawn
/// 
/// @param sprite  Sprite to draw
/// @param image   Image of the sprite to draw
/// @param x       x-coordinate to draw the sprite at
/// @param y       y-coordinate to draw the sprite at
/// @param z       z-coordinate to draw the sprite at
/// @param xScale  Scale of the sprite on the x-axis
/// @param yScale  Scale of the sprite on the y-axis
/// @param zAngle  Rotation of the sprite around the z-axis
/// @param color   Blend color for the sprite (c_white is "no blending")
/// @param alpha   Blend alpha for the sprite (0 being transparent and 1 being 100% opacity)

function CardboardSpriteFloorExt(_sprite, _image, _x, _y, _z, _xScale, _yScale, _zAngle, _color, _alpha)
{
    __CARDBOARD_GLOBAL
    
    var _flooredImage = floor(max(0, _image)) mod sprite_get_number(_sprite);
    var _imageData = _global.__texturePageIndexMap[? __CARDBOARD_MAX_IMAGES*_sprite + _flooredImage];
    
    //Break the batch if we've swapped texture
    if (_imageData.textureIndex != _global.__batchTextureIndex)
    {
        __CardboardBatchComplete();
        
        _global.__batchTexturePointer = _imageData.texturePointer;
        _global.__batchTextureIndex   = _imageData.textureIndex;
    }
    
    //Scale up the image
    var _l = _xScale*_imageData.left;
    var _t = _yScale*_imageData.top;
    var _r = _xScale*_imageData.right;
    var _b = _yScale*_imageData.bottom;
    
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
    
    //Cache the UVs for speeeeeeeed
    var _u0 = _imageData.u0;
    var _v0 = _imageData.v0;
    var _u1 = _imageData.u1;
    var _v1 = _imageData.v1;
    
    //Add this sprite to the vertex buffer
    var _vertexBuffer = _global.__batchVertexBuffer;
    
    vertex_position_3d(_vertexBuffer, _ltX, _ltY, _z); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v0);
    vertex_position_3d(_vertexBuffer, _rtX, _rtY, _z); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0);
    vertex_position_3d(_vertexBuffer, _lbX, _lbY, _z); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1);
    
    vertex_position_3d(_vertexBuffer, _rtX, _rtY, _z); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0);
    vertex_position_3d(_vertexBuffer, _rbX, _rbY, _z); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v1);
    vertex_position_3d(_vertexBuffer, _lbX, _lbY, _z); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1);
    
    if (!_global.__autoBatching && !_global.__buildingModel) CardboardBatchForceSubmit();
}