// Create surface to draw to
var stenSurface = _stenToSurface(sExample);

// Create buffer to write
var stenInputBuffer = buffer_create(1, buffer_grow, 1);
show_debug_message("Input: '" + "This is a string that is used for testing stuff! Cool :)" + "'");
buffer_write(stenInputBuffer, buffer_string, "This is a string that is used for testing stuff! Cool :)");
buffer_resize(stenInputBuffer, buffer_tell(stenInputBuffer));

// Write the buffer to the file
stenSet(stenSurface, stenInputBuffer);

// Read back the surface and print data
var stenOutputBuffer = stenGet(stenSurface);
show_debug_message("Output: '" + buffer_read(stenOutputBuffer, buffer_string) + "'");

// Save the new surface with the data in it
surface_save(stenSurface, "output.png");

// Finish
game_end();