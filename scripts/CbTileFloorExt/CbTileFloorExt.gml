/// Draws a tile parallel to the floor ("lying down")
/// 
/// This function treats a z angle of 0 degrees as orienting the tile to a camera pointing in a "negative y" direction e.g. from (0, 200, 200) to (0, 0, 0)
/// If auto-batching is turned on or you are building a model then the tile may not be immediately drawn
/// 
/// @param tileset  Tileset to draw the tile from
/// @param tileX    Grid x-coordinate of the tile on the tileset
/// @param tileY    Grid y-coordinate of the tile on the tileset
/// @param x        x-coordinate to draw the tile at
/// @param y        y-coordinate to draw the tile at
/// @param z        z-coordinate to draw the tile at
/// @param xScale   Scale of the tile on the x-axis
/// @param yScale   Scale of the tile on the y-axis
/// @param zAngle   Rotation of the tile around the z-axis
/// @param color    Blend color for the tile (c_white is "no blending")
/// @param alpha    Blend alpha for the tile (0 being transparent and 1 being 100% opacity)

function CbTileFloorExt(_tileset, _tileX, _tileY, _x, _y, _z, _xScale, _yScale, _zAngle, _color, _alpha)
{
    __CB_GLOBAL_BUILD
    __CB_INDEX
    __CB_TILE_COMMON_TEXTURE
    __CB_TILE_COMMON_UVS
    
    //Scale up the image
    var _l = 0;
    var _t = 0;
    var _r = _xScale*_tileWidth;
    var _b = _yScale*_tileHeight;
    
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
    
    //Add this tile to the vertex buffer
    var _vertexBuffer = _global.__batch.__vertexBuffer;
    
    if (CB_WRITE_NORMALS)
    {
        if (_global.__doubleSided)
        {
            vertex_position_3d(_vertexBuffer, _ltX, _ltY, _z + CB_DOUBLE_SIDED_SPACING); vertex_normal(_vertexBuffer, 0, 0, 1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v0); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _lbX, _lbY, _z + CB_DOUBLE_SIDED_SPACING); vertex_normal(_vertexBuffer, 0, 0, 1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _rtX, _rtY, _z + CB_DOUBLE_SIDED_SPACING); vertex_normal(_vertexBuffer, 0, 0, 1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0); __CB_WRITE_INDEX
            
            vertex_position_3d(_vertexBuffer, _rtX, _rtY, _z + CB_DOUBLE_SIDED_SPACING); vertex_normal(_vertexBuffer, 0, 0, 1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _lbX, _lbY, _z + CB_DOUBLE_SIDED_SPACING); vertex_normal(_vertexBuffer, 0, 0, 1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _rbX, _rbY, _z + CB_DOUBLE_SIDED_SPACING); vertex_normal(_vertexBuffer, 0, 0, 1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v1); __CB_WRITE_INDEX
            
            vertex_position_3d(_vertexBuffer, _ltX, _ltY, _z - CB_DOUBLE_SIDED_SPACING); vertex_normal(_vertexBuffer, 0, 0, -1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v0); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _rtX, _rtY, _z - CB_DOUBLE_SIDED_SPACING); vertex_normal(_vertexBuffer, 0, 0, -1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _lbX, _lbY, _z - CB_DOUBLE_SIDED_SPACING); vertex_normal(_vertexBuffer, 0, 0, -1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1); __CB_WRITE_INDEX
            
            vertex_position_3d(_vertexBuffer, _rtX, _rtY, _z - CB_DOUBLE_SIDED_SPACING); vertex_normal(_vertexBuffer, 0, 0, -1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _rbX, _rbY, _z - CB_DOUBLE_SIDED_SPACING); vertex_normal(_vertexBuffer, 0, 0, -1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v1); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _lbX, _lbY, _z - CB_DOUBLE_SIDED_SPACING); vertex_normal(_vertexBuffer, 0, 0, -1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1); __CB_WRITE_INDEX
        }
        else
        {
            vertex_position_3d(_vertexBuffer, _ltX, _ltY, _z); vertex_normal(_vertexBuffer, 0, 0, 1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v0); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _lbX, _lbY, _z); vertex_normal(_vertexBuffer, 0, 0, 1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _rtX, _rtY, _z); vertex_normal(_vertexBuffer, 0, 0, 1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0); __CB_WRITE_INDEX
            
            vertex_position_3d(_vertexBuffer, _rtX, _rtY, _z); vertex_normal(_vertexBuffer, 0, 0, 1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _lbX, _lbY, _z); vertex_normal(_vertexBuffer, 0, 0, 1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1); __CB_WRITE_INDEX
            vertex_position_3d(_vertexBuffer, _rbX, _rbY, _z); vertex_normal(_vertexBuffer, 0, 0, 1); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v1); __CB_WRITE_INDEX
        }
    }
    else
    {
        vertex_position_3d(_vertexBuffer, _ltX, _ltY, _z); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v0);
        vertex_position_3d(_vertexBuffer, _lbX, _lbY, _z); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1);
        vertex_position_3d(_vertexBuffer, _rtX, _rtY, _z); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0);
        
        vertex_position_3d(_vertexBuffer, _rtX, _rtY, _z); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v0);
        vertex_position_3d(_vertexBuffer, _lbX, _lbY, _z); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u0, _v1);
        vertex_position_3d(_vertexBuffer, _rbX, _rbY, _z); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, _u1, _v1);
    }
    
    __CB_CONDITIONAL_SUBMIT
}