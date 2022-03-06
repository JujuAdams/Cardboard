/// @param sprite
/// @param image
/// @param x
/// @param y
/// @param z
/// @param xScale
/// @param yScale
/// @param zAngle
/// @param color
/// @param alpha

function CardboardSpriteFloorExt(_sprite, _image, _x, _y, _z, _xScale, _yScale, _zAngle, _color, _alpha)
{
    var _flooredImage = floor(max(0, _image)) mod sprite_get_number(_sprite);
    var _imageData = global.__cardboardTexturePageIndexMap[? (_sprite << __CARDBOARD_MAX_IMAGES) | _flooredImage];
    
    //Break the batch if we've swapped texture
    if (_imageData.textureIndex != global.__cardboardBatchTextureIndex)
    {
        CardboardBatchSubmit();
        
        global.__cardboardBatchTexturePointer = _imageData.texturePointer;
        global.__cardboardBatchTextureIndex   = _imageData.textureIndex;
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
    var _vertexBuffer = global.__cardboardBatchVertexBuffer;
    
    vertex_position_3d(_vertexBuffer, _ltX, _ltY, _z); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v0);
    vertex_position_3d(_vertexBuffer, _rtX, _rtY, _z); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0);
    vertex_position_3d(_vertexBuffer, _lbX, _lbY, _z); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1);
    
    vertex_position_3d(_vertexBuffer, _rtX, _rtY, _z); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0);
    vertex_position_3d(_vertexBuffer, _rbX, _rbY, _z); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v1);
    vertex_position_3d(_vertexBuffer, _lbX, _lbY, _z); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1);
}