/// @param tileset

function __CbClassTileset(_tileset) constructor
{
    static __global      = __CbGlobal();
    static __tilesetDict = __global.__tilesetDict;
    
    __tilesetDict[$ _tileset] = self;
    
    __tileset = _tileset;
    
    layer_set_target_room(0);
    var _layer   = layer_create(0);
    var _tilemap = layer_tilemap_create(_layer, 0, 0, _tileset, 1, 1);
    
    __tileWidth  = tilemap_get_tile_width(_tilemap);
    __tileHeight = tilemap_get_tile_height(_tilemap);
    
    layer_tilemap_destroy(_tilemap);
    layer_destroy(_layer);
    layer_reset_target_room();
    
    __texture = tileset_get_texture(_tileset);
    __UVs     = tileset_get_uvs(_tileset);
    
    __textureWidth   = (__UVs[2] - __UVs[0]) / texture_get_texel_width(__texture);
    __textureHeight  = (__UVs[3] - __UVs[1]) / texture_get_texel_height(__texture);
    
    __tilesetWidth  = __textureWidth  / (__tileWidth  + 4);
    __tilesetHeight = __textureHeight / (__tileHeight + 4);
}