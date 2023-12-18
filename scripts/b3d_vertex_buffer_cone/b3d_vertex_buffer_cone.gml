/// @desc Makes a vertex buffer that describes a cone
/// @param x1
/// @param y1
/// @param z1
/// @param x2
/// @param y2
/// @param z2
/// @param closed
/// @param steps
/// @param UV_l
/// @param UV_t
/// @param UV_r
/// @param UV_b
/// @param colour
function b3d_vertex_buffer_cone(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9, argument10, argument11, argument12) {

	var _x1      = argument0;
	var _y1      = argument1;
	var _z1      = argument2;
	var _x2      = argument3;
	var _y2      = argument4;
	var _z2      = argument5;
	var _closed  = argument6;
	var _steps   = argument7;
	var _uv_l    = argument8;
	var _uv_t    = argument9;
	var _uv_r    = argument10;
	var _uv_b    = argument11;
	var _colour  = argument12;

	_steps = clamp( _steps, 3, 128 );

	var _cc;
	var _ss;
	_cc[ _steps ] = 0;
	_ss[ _steps ] = 0;

	for( var _i = 0; _i <= _steps; _i++ )
	{
	    var _a = 360*_i/_steps;
	    _cc[ _i ] = dcos( _a );
	    _ss[ _i ] = dsin( _a );
	}

	var _mx = 0.5*( _x2 + _x1 );
	var _my = 0.5*( _y2 + _y1 );
	var _rx = 0.5*( _x2 - _x1 );
	var _ry = 0.5*( _y2 - _y1 );


                        
	var _vbuff = vertex_create_buffer();
	vertex_begin( _vbuff, B3D_DEFAULT_FORMAT );

	var _i = 0;
	var _this = [ _mx + _cc[_i]*_rx,  _my + _ss[_i]*_ry, _z1,
	                                              _uv_l,   0,
	                                            _colour,   1,
	                        _cc[_i],            _ss[_i],   0 ];

	for( var _i = 1; _i <= _steps; _i++ )
	{
	    var _prev = _this;
	    var _this = [ _mx + _cc[_i]*_rx,  _my + _ss[_i]*_ry, _z1,
	                        lerp( _uv_l, _uv_r, _i/_steps ),   0,
	                                                _colour,   1,
	                            _cc[_i],            _ss[_i],   0 ];
    
	    b3d_vertex_add( _vbuff,        _mx,      _my,      _z2,   _this[3], _uv_t,    _colour,        1,          0,        0,        1 );
	    b3d_vertex_add( _vbuff,   _prev[0], _prev[1], _prev[2],   _prev[3], _uv_b,   _prev[5], _prev[6],   _prev[7], _prev[8], _prev[9] );
	    b3d_vertex_add( _vbuff,   _this[0], _this[1], _this[2],   _this[3], _uv_b,   _this[5], _this[6],   _this[7], _this[8], _this[9] );
	}

	if ( _closed )
	{
	    var _i = 0;
	    var _this = [ _mx+_cc[_i]*_rx, _my+_ss[_i]*_ry, _z1,
	                                                 0,   0,
	                                           _colour,   1,
	                                0,               0,  -1 ];

	    for( var _i = 1; _i <= _steps; _i++ )
	    {
	        var _prev = _this;
	        var _this = [ _mx+_cc[_i]*_rx, _my+_ss[_i]*_ry, _z1,
	                                                     0,   0,
	                                               _colour,   1,
	                                    0,               0,  -1 ];
        
	        b3d_vertex_add( _vbuff,        _mx,      _my,      _z1,   _uv_l, _uv_b,    _colour,        1,          0,        0,       -1 );
	        b3d_vertex_add( _vbuff,   _prev[0], _prev[1], _prev[2],   _uv_l, _uv_b,   _prev[5], _prev[6],   _prev[7], _prev[8], _prev[9] );
	        b3d_vertex_add( _vbuff,   _this[0], _this[1], _this[2],   _uv_l, _uv_b,   _this[5], _this[6],   _this[7], _this[8], _this[9] );
	    }
	}

	vertex_end( _vbuff );
	vertex_freeze( _vbuff );
	return _vbuff;


}
