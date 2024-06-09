/// @param [overwrite]
/// @param [reverse]
function matrix_chain_push() {

    var _overwrite = ((argument_count > 0) && (argument[0] != undefined))? argument[0] : MATRIX_CHAIN_OVERWRITE_DEFAULT;
    var _reverse   = ((argument_count > 1) && (argument[1] != undefined))? argument[1] : false;

    if ( _reverse )
    {
        global.matrix_chain = matrix_multiply( matrix_get( matrix_world ), global.matrix_chain );
        matrix_stack_push( global.matrix_chain ); //Push a dummy entry
        matrix_stack_set(  global.matrix_chain ); //...then overwrite it immediately
        matrix_set( matrix_world, global.matrix_chain );
    }
    else if ( _overwrite )
    {
        matrix_stack_push( global.matrix_chain ); //Push a dummy entry
        matrix_stack_set(  global.matrix_chain ); //...then overwrite it immediately
        matrix_set( matrix_world, global.matrix_chain );
    }
    else
    {
        matrix_stack_push( global.matrix_chain );
        matrix_set( matrix_world, matrix_stack_top() );
    }


}
