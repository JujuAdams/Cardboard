function CardboardRendererEnd()
{
    //If we've got a pending batch then submit that before resetting draw state
    CardboardBatchSubmit();
    
    //Reset GPU state
    gpu_set_ztestenable(false);
    gpu_set_zwriteenable(false);
    gpu_set_cullmode(cull_noculling);
    gpu_set_alphatestenable(false);
    
    //Restore the old matrices we've been using
    matrix_set(matrix_world,      global.__cardboardOldWorld);
    matrix_set(matrix_view,       global.__cardboardOldView);
    matrix_set(matrix_projection, global.__cardboardOldProjection);
}