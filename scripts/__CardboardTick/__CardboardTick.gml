function __CardboardTick()
{
    __CARDBOARD_GLOBAL
    
    var _i = 0;
    repeat(array_length(_global.__lightingShadowArray))
    {
        _global.__lightingShadowArray[_i].__Tick();
        ++_i;
    }
}