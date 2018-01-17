/// @function stenSet( surface, buffer )
/// @argument surface The surface to write the data from buffer to
/// @argument buffer The data to write to the surface
var _stenSurface = argument[0],
	_stenInputBuffer = argument[1],
	_stenSurfaceBuffer = _stenToBuffer(_stenSurface),
	_stenDataBuffer = buffer_create(44 + buffer_get_size(_stenInputBuffer), buffer_fixed, 1);
	
// Calculate if the data can fit inside the image
if (buffer_get_size(_stenDataBuffer) > buffer_get_size(_stenSurfaceBuffer)) {
	show_error("Unable to fit all input data into the surface.", true);	
}
	
// Fill the data buffer with the size, header, and actual data
buffer_write(_stenDataBuffer, buffer_u32, buffer_get_size(_stenInputBuffer));
buffer_write(_stenDataBuffer, buffer_text, buffer_sha1(_stenInputBuffer, 0, buffer_get_size(_stenInputBuffer)));
buffer_copy(_stenInputBuffer, 0, buffer_get_size(_stenInputBuffer), _stenDataBuffer, 44);

// Write the data buffer to the last 4 bits of each channel of each pixel
for(var i = 0, _i = buffer_get_size(_stenDataBuffer); i < _i; i++) {
	for(var j = 0; j < 2; j++) {
		buffer_poke(_stenSurfaceBuffer, (i * 2) + j, buffer_u8, 
			(buffer_peek(_stenSurfaceBuffer, (i * 2) + j, buffer_u8) & 240) + ((buffer_peek(_stenDataBuffer, i, buffer_u8) >> (4 * j)) & 15)
		);
	}
}

// Set the surface to the modified buffer and clean up previously used buffers
buffer_set_surface(_stenSurfaceBuffer, _stenSurface, 0, 0, 0);
buffer_delete(_stenSurfaceBuffer);
buffer_delete(_stenDataBuffer);

// Return the surface for usage
return _stenSurface;