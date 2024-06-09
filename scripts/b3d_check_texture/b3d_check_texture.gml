/// @param texture
function b3d_check_texture(argument0) {

    if ( is_ptr( argument0 ) ) return argument0;
    if ( !is_real( argument0 ) ) return B3D_DEFAULT_TEXTURE;
    if ( !sprite_exists( argument0 ) ) return B3D_DEFAULT_TEXTURE;
    return sprite_get_texture( argument0, 0 );


}
