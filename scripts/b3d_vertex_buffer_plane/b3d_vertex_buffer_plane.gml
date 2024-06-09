/// @param x
/// @param y
/// @param z
/// @param nx
/// @param ny
/// @param nz
/// @param size
/// @param UV_l
/// @param UV_t
/// @param UV_r
/// @param UV_b
function b3d_vertex_buffer_plane(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9, argument10) {

    var _x    = argument0;
    var _y    = argument1;
    var _z    = argument2;
    var _nx   = argument3;
    var _ny   = argument4;
    var _nz   = argument5;
    var _size = argument6;
    var _uv_l = argument7;
    var _uv_t = argument8;
    var _uv_r = argument9;
    var _uv_b = argument10;

    var _position = [_x, _y, _z];
    var _normal = vec3_normalise( [_nx, _ny, _nz] );

    var _random_position = _position;
    var _basis_i = vec3_normalise( vec3_cross( _normal, _random_position ) );

    if ( vec3_is_zero_length( _basis_i ) )
    {
        _random_position[0] += 1;
        _basis_i = vec3_normalise( vec3_cross( _normal, _random_position ) );
    
        if ( vec3_is_zero_length( _basis_i ) )
        {
            _random_position[1] += 1;
            _basis_i = vec3_normalise( vec3_cross( _normal, _random_position ) );
        
            if ( vec3_is_zero_length( _basis_i ) )
            {
                _random_position[2] += 1;
                _basis_i = vec3_normalise( vec3_cross( _normal, _random_position ) );
            
                if ( vec3_is_zero_length( _basis_i ) )
                {
                    return undefined;
                }
            }
        }
    }

    var _basis_j = vec3_normalise( vec3_cross( _normal, _basis_i  ) );

    if ( _size == undefined ) _size = B3D_INFINITE_SCALE;
    if ( _size != 2 )
    {
        _basis_i = vec3_scale( _basis_i, _size/2 );
        _basis_j = vec3_scale( _basis_j, _size/2 );
    }

    var _a = vec3_add(      _position, _basis_j );
    var _b = vec3_add(      _position, _basis_i );
    var _c = vec3_subtract( _position, _basis_i );
    var _d = vec3_subtract( _position, _basis_j );

    var _colour = c_white,
    var _alpha  = 1;

    var _vbuff = vertex_create_buffer();
    vertex_begin( _vbuff, B3D_DEFAULT_FORMAT );

    b3d_vertex_add( _vbuff,   _a[0], _a[1], _a[2],   _uv_l, _uv_t,   _colour, _alpha,   _nx, _ny, _nz );
    b3d_vertex_add( _vbuff,   _c[0], _c[1], _c[2],   _uv_l, _uv_b,   _colour, _alpha,   _nx, _ny, _nz );
    b3d_vertex_add( _vbuff,   _d[0], _d[1], _d[2],   _uv_r, _uv_b,   _colour, _alpha,   _nx, _ny, _nz );

    b3d_vertex_add( _vbuff,   _d[0], _d[1], _d[2],   _uv_r, _uv_b,   _colour, _alpha,   _nx, _ny, _nz );
    b3d_vertex_add( _vbuff,   _b[0], _b[1], _b[2],   _uv_r, _uv_t,   _colour, _alpha,   _nx, _ny, _nz );
    b3d_vertex_add( _vbuff,   _a[0], _a[1], _a[2],   _uv_l, _uv_t,   _colour, _alpha,   _nx, _ny, _nz );

    vertex_end( _vbuff );
    vertex_freeze( _vbuff );
    return _vbuff;


}
