/// @param tileset

function __CbGetTileset(_tilesetIndex)
{
    static _tilesetDict = __CbGlobal().__tilesetDict;
    var _tileset = _tilesetDict[$ _tilesetIndex];
    
    if (!is_struct(_tileset)) _tileset = new __CbClassTileset(_tilesetIndex);
    return _tileset;
}