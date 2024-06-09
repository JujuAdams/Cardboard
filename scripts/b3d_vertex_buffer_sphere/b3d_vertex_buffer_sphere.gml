/// @desc Makes a vertex buffer that describes a sphere
/// @param x1
/// @param y1
/// @param z1
/// @param x2
/// @param y2
/// @param z2
/// @param steps
/// @param UV_l
/// @param UV_t
/// @param UV_r
/// @param UV_b
function b3d_vertex_buffer_sphere(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9, argument10) {

    var _x1    = argument0;
    var _y1    = argument1;
    var _z1    = argument2;
    var _x2    = argument3;
    var _y2    = argument4;
    var _z2    = argument5;
    var _steps = argument6;
    var _uv_l  = argument7;
    var _uv_t  = argument8;
    var _uv_r  = argument9;
    var _uv_b  = argument10;

    _steps = clamp( 3, 128, _steps );
    var _rows = 0.5*_steps + 0.5;

    // Create sin and cos tables
    var _cc;
    var _ss;
    _cc[_steps] = 0;
    _ss[_steps] = 0;

    for( var _i = 0; _i <= _steps; _i++ )
    {
        var _rad = _i * 360 / _steps;
        _cc[_i] = dcos( _rad );
        _ss[_i] = dsin( _rad );
    }

    var _mx = 0.5*( _x2 + _x1 );
    var _my = 0.5*( _y2 + _y1 );
    var _mz = 0.5*( _z2 + _z1 );
    var _rx = 0.5*( _x2 - _x1 );
    var _ry = 0.5*( _y2 - _y1 );
    var _rz = 0.5*( _z2 - _z1 );

    var _vbuff = vertex_create_buffer();
    vertex_begin( _vbuff, B3D_DEFAULT_FORMAT );
    
    for( var _j = 0; _j < _rows; _j++ )
    {
        var _row1rad =  _j    * 180 / _rows;
        var _row2rad = (_j+1) * 180 / _rows;
        var _rh1 = dcos( _row1rad );
        var _rd1 = dsin( _row1rad );
        var _rh2 = dcos( _row2rad );
        var _rd2 = dsin( _row2rad );
    
        var _i = 0;
        var _this_a = [ _mx+_rx*_rd1*_cc[_i],  _my+_ry*_rd1*_ss[_i], _mz+_rz*_rh1,
                                   _i/_steps,              _j/_rows,
                                     c_white,                     1,
                                _rd1*_cc[_i],          _rd1*_ss[_i],         _rh1 ];
        
        var _this_b = [ _mx+_rx*_rd2*_cc[_i],  _my+_ry*_rd2*_ss[_i], _mz+_rz*_rh2,
                                   _i/_steps,          (_j+1)/_rows,
                                     c_white,                     1,
                                _rd2*_cc[_i],          _rd2*_ss[_i],         _rh2 ];
    
        for( var _i = 1; _i <= _steps; _i++ )
        {
            var _prev_a = _this_a;
            var _prev_b = _this_b;
        
            var _this_a = [ _mx+_rx*_rd1*_cc[_i],  _my+_ry*_rd1*_ss[_i], _mz+_rz*_rh1,
                                       _i/_steps,              _j/_rows,
                                         c_white,                     1,
                                    _rd1*_cc[_i],          _rd1*_ss[_i],         _rh1 ];
        
            var _this_b = [ _mx+_rx*_rd2*_cc[_i],  _my+_ry*_rd2*_ss[_i], _mz+_rz*_rh2,
                                       _i/_steps,          (_j+1)/_rows,
                                         c_white,                     1,
                                    _rd2*_cc[_i],          _rd2*_ss[_i],         _rh2 ];
        
            b3d_vertex_add( _vbuff,   _prev_a[0], _prev_a[1], _prev_a[2],   lerp( _uv_l, _uv_r, _prev_a[3] ), lerp( _uv_t, _uv_b, _prev_a[4] ),   _prev_a[5], _prev_a[6],   _prev_a[7], _prev_a[8], _prev_a[9] );
            b3d_vertex_add( _vbuff,   _prev_b[0], _prev_b[1], _prev_b[2],   lerp( _uv_l, _uv_r, _prev_b[3] ), lerp( _uv_t, _uv_b, _prev_b[4] ),   _prev_b[5], _prev_b[6],   _prev_b[7], _prev_b[8], _prev_b[9] );
            b3d_vertex_add( _vbuff,   _this_a[0], _this_a[1], _this_a[2],   lerp( _uv_l, _uv_r, _this_a[3] ), lerp( _uv_t, _uv_b, _this_a[4] ),   _this_a[5], _this_a[6],   _this_a[7], _this_a[8], _this_a[9] );
        
            b3d_vertex_add( _vbuff,   _prev_b[0], _prev_b[1], _prev_b[2],   lerp( _uv_l, _uv_r, _prev_b[3] ), lerp( _uv_t, _uv_b, _prev_b[4] ),   _prev_b[5], _prev_b[6],   _prev_b[7], _prev_b[8], _prev_b[9] );
            b3d_vertex_add( _vbuff,   _this_b[0], _this_b[1], _this_b[2],   lerp( _uv_l, _uv_r, _this_b[3] ), lerp( _uv_t, _uv_b, _this_b[4] ),   _this_b[5], _this_b[6],   _this_b[7], _this_b[8], _this_b[9] );
            b3d_vertex_add( _vbuff,   _this_a[0], _this_a[1], _this_a[2],   lerp( _uv_l, _uv_r, _this_a[3] ), lerp( _uv_t, _uv_b, _this_a[4] ),   _this_a[5], _this_a[6],   _this_a[7], _this_a[8], _this_a[9] );
        }
    }

    vertex_end( _vbuff );
    vertex_freeze( _vbuff );
    return _vbuff;


}
