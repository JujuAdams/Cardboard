/// @param x1
/// @param y1
/// @param z1
/// @param x2
/// @param y2
/// @param z2
/// @param closed
/// @param steps
function b3d_vertex_buffer_cylinder(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7) {

    var _x1     = argument0;
    var _y1     = argument1;
    var _z1     = argument2;
    var _x2     = argument3;
    var _y2     = argument4;
    var _z2     = argument5;
    var _closed = argument6;
    var _steps  = argument7;

    _steps = clamp( _steps, 3, 128 );

    var _cc;
    var _ss;
    _cc[ _steps ] = 0;
    _ss[ _steps ] = 0;

    for( var _i = 0; _i <= _steps; _i++ )
    {
        var _deg = 360*_i / _steps;
        _cc[ _i ] = dcos( _deg );
        _ss[ _i ] = dsin( _deg );
    }

    var _mx = 0.5*( _x2 + _x1 );
    var _my = 0.5*( _y2 + _y1 );
    var _rx = 0.5*( _x2 - _x1 );
    var _ry = 0.5*( _y2 - _y1 );

    var _vbuff = vertex_create_buffer();
    vertex_begin( _vbuff, B3D_DEFAULT_FORMAT );
  
    var _bx = _mx + _cc[0]*_rx;
    var _by = _my + _ss[0]*_ry;
    
    for( var _i = 1; _i <= _steps; _i++ )
    {
        var _j = (_i+1) mod _steps;
        var _u = _i / _steps;
    
        var _ax = _bx;
        var _ay = _by;
        var _bx = _mx + _cc[_i]*_rx;
        var _by = _my + _ss[_i]*_ry;
        
        if ( _closed )
        {
            b3d_vertex_add( _vbuff,   _mx, _my, _z2,   0, 1,   c_white, 1,   0, 0,  1 );
            b3d_vertex_add( _vbuff,   _ax, _ay, _z2,   0, 1,   c_white, 1,   0, 0,  1 );
            b3d_vertex_add( _vbuff,   _bx, _by, _z2,   0, 1,   c_white, 1,   0, 0,  1 );
        
            b3d_vertex_add( _vbuff,   _mx, _my, _z1,   0, 0,   c_white, 1,   0, 0, -1 );
            b3d_vertex_add( _vbuff,   _bx, _by, _z1,   0, 0,   c_white, 1,   0, 0, -1 );
            b3d_vertex_add( _vbuff,   _ax, _ay, _z1,   0, 0,   c_white, 1,   0, 0, -1 );
        }
    
        b3d_vertex_add( _vbuff,   _ax, _ay, _z1,   _u, 0,   c_white, 1,   _cc[_i], _ss[_i], 0 );
        b3d_vertex_add( _vbuff,   _bx, _by, _z1,   _u, 0,   c_white, 1,   _cc[_j], _ss[_j], 0 );
        b3d_vertex_add( _vbuff,   _bx, _by, _z2,   _u, 1,   c_white, 1,   _cc[_j], _ss[_j], 0 );
    
        b3d_vertex_add( _vbuff,   _bx, _by, _z2,   _u, 1,   c_white, 1,   _cc[_j], _ss[_j], 0 );
        b3d_vertex_add( _vbuff,   _ax, _ay, _z1,   _u, 0,   c_white, 1,   _cc[_i], _ss[_i], 0 );
        b3d_vertex_add( _vbuff,   _ax, _ay, _z2,   _u, 1,   c_white, 1,   _cc[_i], _ss[_i], 0 );
    }

    vertex_end( _vbuff );
    vertex_freeze( _vbuff );
    return _vbuff;


}
