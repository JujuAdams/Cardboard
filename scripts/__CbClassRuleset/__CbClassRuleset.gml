function __CbClassRuleset() constructor
{
    __tilesetDict = {};
    
    static AddTileset = function(_tileset)
    {
        var _ruleset = __tilesetDict[$ _tileset];
        if (!is_struct(_ruleset))
        {
            _ruleset = new __CbClassRulesetTilemap(_tileset);
            __tilesetDict[$ _tileset] = _ruleset;
        }
        
        return _ruleset;
    }
    
    static DeleteTileset = function(_tileset)
    {
        variable_struct_remove(__tilesetDict, _tileset);
        return self;
    }
}