/// Draws a surface perpendicular to the floor ("standing up") and facing the camera
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
/// @param xScale       Scale of the surface on the x-axis
/// @param zScale       Scale of the surface on the z-axis
/// @param yAngle       Rotation of the surface around the y-axis
/// @param color        Blend color for the surface (c_white is "no blending")
/// @param alpha        Blend alpha for the surface (0 being transparent and 1 being 100% opacity)
/// @param [xOrigin=0]  x-offset
/// @param [yOrigin=0]  y-offset

function CardboardSurfaceBillboardExt(_sprite, _image, _x, _y, _z, _xScale, _zScale, _yAngle, _color, _alpha, _xOrigin = 0, _yOrigin = 0)
{
    __CARDBOARD_GLOBAL
    __CARDBOARD_SURFACE_COMMON_TEXTURE
    
    //Scale up the image
    var _l =     -_xScale*_xOrigin;
    var _t =     -_zScale*_yOrigin;
    var _r = _l + _xScale*surface_get_width(_surface);
    var _b = _t + _zScale*surface_get_height(_surface);
    
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
    
    //Add this sprite to the vertex buffer
    var _vertexBuffer = _global.__batchVertexBuffer;
    
    vertex_position_3d(_vertexBuffer, _ltX, _ltY, _ltZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 0, 0);
    vertex_position_3d(_vertexBuffer, _rtX, _rtY, _rtZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 1, 0);
    vertex_position_3d(_vertexBuffer, _lbX, _lbY, _lbZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 0, 1);
    
    vertex_position_3d(_vertexBuffer, _rtX, _rtY, _rtZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 1, 0);
    vertex_position_3d(_vertexBuffer, _rbX, _rbY, _rbZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 1, 1);
    vertex_position_3d(_vertexBuffer, _lbX, _lbY, _lbZ); vertex_color(_vertexBuffer, _color, _alpha); vertex_texcoord(_vertexBuffer, 0, 1);
    
    __CARDBOARD_FORCE_SUBMIT_CONDITION
}