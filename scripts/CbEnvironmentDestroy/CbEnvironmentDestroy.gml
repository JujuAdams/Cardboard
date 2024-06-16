/// @param environment

function CbEnvironmentDestroy(_environment)
{
    if (_environment == undefined) return;
    _environment.Destroy();
}