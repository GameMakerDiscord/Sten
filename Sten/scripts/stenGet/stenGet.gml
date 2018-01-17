/// @function stenRead( surface )
/// @argument surface The surface to get the data from
var _stenSurface = argument[0],
	_stenOutputBuffer = undefined,
	_stenSurfaceBuffer = _stenToBuffer(_stenSurface);

// Read the size from the image (u32, 4 bytes)
var _stenSize = 0;
for(var i = 0; i < 4; i++) {
	var _stenByte = 0;
	for(var j = 0; j < 2; j++) {
		_stenByte += (buffer_read(_stenSurfaceBuffer, buffer_u8) & 0xF) << j * 0x4;
	}
	_stenSize += _stenByte << 8 * i;
}

// Read the hash from the image (40 bytes)
var _stenHash = "";
for(var i = 0; i < 40; i++) {
	var _stenByte = 0;
	for(var j = 0; j < 2; j++) {
		_stenByte += (buffer_read(_stenSurfaceBuffer, buffer_u8) & 0xF) << j * 0x4;
	}
	_stenHash += chr(_stenByte);
}

// Use the previously read size to read the actual data (and create a buffer for it)
var _stenOutputBuffer = buffer_create(_stenSize, buffer_fixed, 1);
for(var i = 0; i < _stenSize; i++) {
	var _stenByte = 0;
	for(var j = 0; j < 2; j++) {
		_stenByte += (buffer_read(_stenSurfaceBuffer, buffer_u8) & 0xF) << j * 0x4;
	}
	buffer_write(_stenOutputBuffer, buffer_u8, _stenByte);
}

// Check the hash to verify integrity of read data
if (buffer_sha1(_stenOutputBuffer, 0, buffer_tell(_stenOutputBuffer)) != _stenHash) {
	show_error("Could not verify the integrity of the data read from image, data could have been compressed.", true);	
}

// Free previously used buffer from memory
buffer_delete(_stenSurfaceBuffer);

// Return the final buffer
buffer_seek(_stenOutputBuffer, buffer_seek_start, 0);
return _stenOutputBuffer;