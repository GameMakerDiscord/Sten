/// @function _stenToBuffer( surface )
/// @argument surface The surface to convert to a buffer
var _stenBuffer = buffer_create(4 * surface_get_width(argument[0]) * surface_get_height(argument[0]), buffer_fixed, 1);
buffer_get_surface(_stenBuffer, argument[0], 0, 0, 0);
buffer_seek(_stenBuffer, buffer_seek_start, 0);
return _stenBuffer;