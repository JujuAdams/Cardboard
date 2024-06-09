/// @param plane0{vec4}
/// @param plane1{vec4}
///
/// Returns: <undefined> if no valid intersection exists
/// Returns: a 6-element array if an intersection exists consisting of 3D co-ordinates describing a line:
///          [0][1][2] giving the origin of the line
function b3d_plane_plane_intersection(argument0, argument1) {
    //           [3][4][5] giving the direction of the line

    var _plane_0 = argument0;
    var _plane_1 = argument1;

    var _line_dir = vec3_cross( _plane_0, _plane_1 );

    var _plane_0_x = _plane_0[0];
    var _plane_0_y = _plane_0[1];
    var _plane_0_z = _plane_0[2];
    var _plane_0_d = _plane_0[3];

    var _plane_1_x = _plane_1[0];
    var _plane_1_y = _plane_1[1];
    var _plane_1_z = _plane_1[2];
    var _plane_1_d = _plane_1[3];

    var _diff_d = _plane_0_d - _plane_1_d;

    // p0x + p1y + p2z = p3
    // q0x + q1y + q2z = q3

    if ( _line_dir[2] != 0 )
    {
        var _diff_x = _plane_0_x - _plane_1_x;
        var _diff_y = _plane_0_y - _plane_1_y;
        var _ratio_x = _plane_0_x / _diff_x;
        var _ratio_y = _plane_0_y / _diff_y;
        // force z=0
        // p0x + p1y = p3,   q0x + q1y = q3
        // x = (p3 – r1.d3) / (p0 – r1.d0)
        // y = (r0.d3 – p3) / (r0.d1 – p1)
        var _x = (_plane_0_d - _ratio_y*_diff_d) / (_plane_0_x - _ratio_y*_diff_x);
        var _y = (_ratio_x*_diff_d - _plane_0_d) / (_ratio_x*_diff_y - _plane_0_y);
        var _z = 0; //(_plane_0_x*_x + _plane_0_y*_y - _plane_0_d) / _plane_0_z;
    }
    else if ( _line_dir[1] != 0 )
    {
        var _diff_x = _plane_0_x - _plane_1_x;
        var _diff_z = _plane_0_z - _plane_1_z;
        var _ratio_x = _plane_0_x / _diff_x;
        var _ratio_z = _plane_0_z / _diff_z;
        // force y=0
        // p0x + p2z = p3,   q0x + q2z = q3
        // x = (p3 – r2.d3) / (p0 – r2.d0)
        // z = (r0.d3 – p3) / (r0.d2 – p2)
        var _x = (_plane_0_d - _ratio_z*_diff_d) / (_plane_0_x - _ratio_z*_diff_x);
        var _z = (_ratio_x*_diff_d - _plane_0_d) / (_ratio_x*_diff_z - _plane_0_z);
        var _y = 0; //(_plane_0_x*_x + _plane_0_z*_z - _plane_0_d) / _plane_0_y;
    }
    else if ( _line_dir[0] != 0 )
    {
        var _diff_y = _plane_0_y - _plane_1_y;
        var _diff_z = _plane_0_z - _plane_1_z;
        var _ratio_y = _plane_0_y / _diff_y;
        var _ratio_z = _plane_0_z / _diff_z;
        // force x=0
        // p1y + p2z = p3,   q1y + q2z = q3
        // y = (p3 – r2.d3) / (p1 – r2.d1)
        // z = (r1.d3 – p3) / (r1.d2 – p2)
        var _y = (_plane_0_d - _ratio_z*_diff_d) / (_plane_0_y - _ratio_z*_diff_y);
        var _z = (_ratio_y*_diff_d - _plane_0_d) / (_ratio_y*_diff_z - _plane_0_z);
        var _x = 0; //(_plane_0_y*_y + _plane_0_z*_z - _plane_0_d) / _plane_0_x;
    }
    else
    {
        return undefined;
    }

    return [           _x,           _y,           _z,
             _line_dir[0], _line_dir[1], _line_dir[2] ];


}
