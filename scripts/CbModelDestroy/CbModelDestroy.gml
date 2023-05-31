/// Frees vertex buffer data associated with the model
/// 
/// @param model  The model to destroy

function CbModelDestroy(_model)
{
    _model.__Destroy();
}