/// @param sprite
/// @param image
/// @param x
/// @param y
/// @param z
/// @param xScale
/// @param zScale
/// @param yAngle
/// @param color
/// @param alpha

function CardboardSpriteBillboardExt(_sprite, _image, _x, _y, _z, _xScale, _zScale, _yAngle, _color, _alpha)
{
    var _flooredImage = floor(max(0, _image)) mod sprite_get_number(_sprite);
    var _imageData = global.__cardboardTexturePageIndexMap[? __CARDBOARD_MAX_IMAGES*_sprite + _flooredImage];
    
    //Break the batch if we've swapped texture
    if (_imageData.textureIndex != global.__cardboardBatchTextureIndex)
    {
        __CardboardBatchComplete();
        
        global.__cardboardBatchTexturePointer = _imageData.texturePointer;
        global.__cardboardBatchTextureIndex   = _imageData.textureIndex;
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
    var _sin = dsin(-global.__cardboardBillboardYaw);
    var _cos = dcos(-global.__cardboardBillboardYaw);
    
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
    var _vertexBuffer = global.__cardboardBatchVertexBuffer;
    
    vertex_position_3d(_vertexBuffer, _ltX, _ltY, _ltZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v0);
    vertex_position_3d(_vertexBuffer, _rtX, _rtY, _rtZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0);
    vertex_position_3d(_vertexBuffer, _lbX, _lbY, _lbZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1);
    
    vertex_position_3d(_vertexBuffer, _rtX, _rtY, _rtZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0);
    vertex_position_3d(_vertexBuffer, _rbX, _rbY, _rbZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v1);
    vertex_position_3d(_vertexBuffer, _lbX, _lbY, _lbZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1);
}