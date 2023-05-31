/// Submits the given model to the GPU (draws the model)
/// 
/// @param model  The model to submit to the GPU

function CbModelSubmit(_model)
{
    _model.__Submit();
}