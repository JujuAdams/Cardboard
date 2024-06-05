/// @param tileset

function __CbClassTileset(_tileset) constructor
{
    static __global      = __CbBuildGlobal();
    static __tilesetDict = __global.__tilesetDict;
    
    __tilesetDict[$ _tileset] = self;
    
    __tileset     = _tileset;
    __tilesetInfo = tileset_get_info(_tileset);
    
    __tileWidth      = __tilesetInfo.tile_width;
    __tileHeight     = __tilesetInfo.tile_height;
    __tileSeparatorH = __tilesetInfo.tile_horizontal_separator;
    __tileSeparatorV = __tilesetInfo.tile_vertical_separator;
    __textureWidth   = __tilesetInfo.width;
    __textureHeight  = __tilesetInfo.height;
    __tilesetWidth   = __tilesetInfo.tile_count  / __tilesetInfo.tile_columns;
    __tilesetHeight  = __tilesetInfo.tile_columns;
    
    __tileAnimMap = ds_map_create();
    
    var _framesStruct = __tilesetInfo.frames;
    var _namesArray = variable_struct_get_names(_framesStruct);
    var _i = 0;
    repeat(array_length(_namesArray))
    {
        var _name = _namesArray[_i];
        __tileAnimMap[? real(_name)] = _framesStruct[$ _name];
        ++_i;
    }
    
    __texture = tileset_get_texture(_tileset);
    __UVs     = tileset_get_uvs(_tileset);
}