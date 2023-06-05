function __CbTick()
{
    __CB_GLOBAL
    
    //Clean out the global array of lights
    with(_global.__lighting)
    {
        var _i = 0;
        repeat(array_length(__array))
        {
            var _light = __array[_i];
            if (!weak_ref_alive(_light) || _light.ref.__destroyed)
            {
                array_delete(__array, _i, 1);
            }
            else
            {
                ++_i;
            }
        }
    }
}