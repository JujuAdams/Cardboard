/// Draws a tile perpendicular to the floor ("standing up") and facing the camera
/// 
/// This function requires that you call CbViewMatrixSet() before drawing the billboarded tile
/// If auto-batching is turned on or you are building a model then the tile may not be immediately drawn
/// 
/// N.B. Billboarded tiles that have been written into a model will use the camera position at the time
///      that the tile is written into a model and may not necessarily follow the camera when the model
///      is drawn thereafter
/// 
/// @param tileset  Tileset to draw the tile from
/// @param tileX    Grid x-coordinate of the tile on the tileset
/// @param tileY    Grid y-coordinate of the tile on the tileset
/// @param x        x-coordinate to draw the tile at
/// @param y        y-coordinate to draw the tile at
/// @param z        z-coordinate to draw the tile at
/// @param xScale   Scale of the tile on the x-axis
/// @param zScale   Scale of the tile on the z-axis
/// @param yAngle   Rotation of the tile around the y-axis
/// @param color    Blend color for the tile (c_white is "no blending")
/// @param alpha    Blend alpha for the tile (0 being transparent and 1 being 100% opacity)

function CbTileBillboardExt(_tileset, _tileX, _tileY, _x, _y, _z, _xScale, _zScale, _yAngle, _color, _alpha)
{
    __CB_GLOBAL_BUILD
    __CB_INDEX
    __CB_TILE_COMMON_TEXTURE
    __CB_TILE_COMMON_UVS
    
    //Scale up the image
    var _l = 0;
    var _t = 0;
    var _r = _xScale*_tileWidth;
    var _b = _zScale*_tileHeight;
    
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
    var _sin = _global.__billboard.__yawSin;
    var _cos = _global.__billboard.__yawCos;
    
    var _ltX = _ltX0*_cos + _x;
    var _ltY = _ltX0*_sin + _y;
    var _rtX = _rtX0*_cos + _x;
    var _rtY = _rtX0*_sin + _y;
    var _lbX = _lbX0*_cos + _x;
    var _lbY = _lbX0*_sin + _y;
    var _rbX = _rbX0*_cos + _x;
    var _rbY = _rbX0*_sin + _y;
    
    //Add this tile to the vertex buffer
    var _vertexBuffer = _global.__batch.__vertexBuffer;
    
    if (CB_WRITE_NORMALS)
    {
        var _normalX = -_sin;
        var _normalY =  _cos;
        
        if (_global.__doubleSided)
        {
            var _dX = CB_DOUBLE_SIDED_SPACING*_normalX;
            var _dY = CB_DOUBLE_SIDED_SPACING*_normalY;
            
            vertex_position_3d(_vertexBuffer, _ltX + _dX, _ltY + _dY, _ltZ); vertex_normal(_vertexBuffer, _normalX, _normalY, 0); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v0); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _lbX + _dX, _lbY + _dY, _lbZ); vertex_normal(_vertexBuffer, _normalX, _normalY, 0); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _rtX + _dX, _rtY + _dY, _rtZ); vertex_normal(_vertexBuffer, _normalX, _normalY, 0); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0); __CB_WRITE_INDEX
            
            vertex_position_3d(_vertexBuffer, _rtX + _dX, _rtY + _dY, _rtZ); vertex_normal(_vertexBuffer, _normalX, _normalY, 0); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _lbX + _dX, _lbY + _dY, _lbZ); vertex_normal(_vertexBuffer, _normalX, _normalY, 0); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _rbX + _dX, _rbY + _dY, _rbZ); vertex_normal(_vertexBuffer, _normalX, _normalY, 0); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v1); __CB_WRITE_INDEX
            
            vertex_position_3d(_vertexBuffer, _ltX - _dX, _ltY - _dY, _ltZ); vertex_normal(_vertexBuffer, -_normalX, -_normalY, 0); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v0); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _rtX - _dX, _rtY - _dY, _rtZ); vertex_normal(_vertexBuffer, -_normalX, -_normalY, 0); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _lbX - _dX, _lbY - _dY, _lbZ); vertex_normal(_vertexBuffer, -_normalX, -_normalY, 0); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1); __CB_WRITE_INDEX
            
            vertex_position_3d(_vertexBuffer, _rtX - _dX, _rtY - _dY, _rtZ); vertex_normal(_vertexBuffer, -_normalX, -_normalY, 0); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _rbX - _dX, _rbY - _dY, _rbZ); vertex_normal(_vertexBuffer, -_normalX, -_normalY, 0); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v1); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _lbX - _dX, _lbY - _dY, _lbZ); vertex_normal(_vertexBuffer, -_normalX, -_normalY, 0); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1); __CB_WRITE_INDEX
        }
        else
        {
            vertex_position_3d(_vertexBuffer, _ltX, _ltY, _ltZ); vertex_normal(_vertexBuffer, _normalX, _normalY, 0); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v0); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _lbX, _lbY, _lbZ); vertex_normal(_vertexBuffer, _normalX, _normalY, 0); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _rtX, _rtY, _rtZ); vertex_normal(_vertexBuffer, _normalX, _normalY, 0); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0); __CB_WRITE_INDEX
            
            vertex_position_3d(_vertexBuffer, _rtX, _rtY, _rtZ); vertex_normal(_vertexBuffer, _normalX, _normalY, 0); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _lbX, _lbY, _lbZ); vertex_normal(_vertexBuffer, _normalX, _normalY, 0); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _rbX, _rbY, _rbZ); vertex_normal(_vertexBuffer, _normalX, _normalY, 0); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v1); __CB_WRITE_INDEX
        }
    }
    else
    {
        vertex_position_3d(_vertexBuffer, _ltX, _ltY, _ltZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v0);
        vertex_position_3d(_vertexBuffer, _lbX, _lbY, _lbZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1);
        vertex_position_3d(_vertexBuffer, _rtX, _rtY, _rtZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0);
        
        vertex_position_3d(_vertexBuffer, _rtX, _rtY, _rtZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0);
        vertex_position_3d(_vertexBuffer, _lbX, _lbY, _lbZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1);
        vertex_position_3d(_vertexBuffer, _rbX, _rbY, _rbZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v1);
    }
    
    __CB_CONDITIONAL_SUBMIT
}