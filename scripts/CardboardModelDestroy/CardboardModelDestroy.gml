/// Frees vertex buffer data associated with the model
/// 
/// @param model  The model to destroy

function CardboardModelDestroy(_model)
{
    _model.__Destroy();
}