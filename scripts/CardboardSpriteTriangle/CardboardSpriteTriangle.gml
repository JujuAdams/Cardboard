/// Draws a sprite stretched over an arbitrary quadrilateral
/// 
/// If auto-batching is turned on or you are building a model then the sprite may not be immediately drawn
/// 
/// @param sprite  Sprite to draw
/// @param image   Image of the sprite to draw
/// @param x1      x-coordinate for the top-left corner of the texture
/// @param y1      y-coordinate for the top-left corner of the texture
/// @param z1      z-coordinate for the top-left corner of the texture
/// @param u1
/// @param v1
/// @param x2      x-coordinate for the top-right corner of the texture
/// @param y2      y-coordinate for the top-right corner of the texture
/// @param z2      z-coordinate for the top-right corner of the texture
/// @param u2
/// @param v2
/// @param x3      x-coordinate for the bottom-left corner of the texture
/// @param y3      y-coordinate for the bottom-left corner of the texture
/// @param u3
/// @param v3
/// @param color   Blend color for the sprite (c_white is "no blending")
/// @param alpha   Blend alpha for the sprite (0 being transparent and 1 being 100% opacity)

function CardboardSpriteTriangle()
{
    var _sprite = argument[0];
    var _image  = argument[1];
    var _x1     = argument[2];
    var _y1     = argument[3];
    var _z1     = argument[4];
    var _u1prop = argument[5];
    var _v1prop = argument[6];
    var _x2     = argument[7];
    var _y2     = argument[8];
    var _z2     = argument[9];
    var _u2prop = argument[10];
    var _v2prop = argument[11];
    var _x3     = argument[12];
    var _y3     = argument[13];
    var _z3     = argument[14];
    var _u3prop = argument[15];
    var _v3prop = argument[16];
    var _color  = argument[17];
    var _alpha  = argument[18];
    
    var _flooredImage = floor(max(0, _image)) mod sprite_get_number(_sprite);
    var _imageData = global.__cardboardTexturePageIndexMap[? __CARDBOARD_MAX_IMAGES*_sprite + _flooredImage];
    
    //Break the batch if we've swapped texture
    if (_imageData.textureIndex != global.__cardboardBatchTextureIndex)
    {
        __CardboardBatchComplete();
        
        global.__cardboardBatchTexturePointer = _imageData.texturePointer;
        global.__cardboardBatchTextureIndex   = _imageData.textureIndex;
    }
    
    //Cache the UVs for speeeeeeeed
    var _u0source = _imageData.u0;
    var _v0source = _imageData.v0;
    var _u1source = _imageData.u1;
    var _v1source = _imageData.v1;
    
    //Add this sprite to the vertex buffer
    var _vertexBuffer = global.__cardboardBatchVertexBuffer;
    
    vertex_position_3d(_vertexBuffer, _x1, _y1, _z1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, lerp(_u0source, _u1source, _u1prop), lerp(_v0source, _v1source, _v1prop));
    vertex_position_3d(_vertexBuffer, _x2, _y2, _z2); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, lerp(_u0source, _u1source, _u2prop), lerp(_v0source, _v1source, _v2prop));
    vertex_position_3d(_vertexBuffer, _x3, _y3, _z3); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, lerp(_u0source, _u1source, _u3prop), lerp(_v0source, _v1source, _v3prop));
    
    if (!global.__cardboardAutoBatching && !global.__cardboardBuildingModel) CardboardBatchForceSubmit();
}