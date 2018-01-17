/// @function _stenToSurface( sprite )
/// @argument sprite The sprite to convert to a surface
var _stenSurface = surface_create(sprite_get_width(argument[0]), sprite_get_height(argument[0]));
surface_set_target(_stenSurface);
gpu_set_blendenable(false);
draw_sprite(argument[0], 0, 0, 0);
gpu_set_blendenable(true);
surface_reset_target();
return _stenSurface;