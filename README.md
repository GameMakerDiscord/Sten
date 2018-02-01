# Sten
Least-significant nibble stenography implementation for GameMaker

# Compatibility
Windows: ✓

Mac: ✓

HTML5: ?

Ubuntu: ?

Android: ?

iOS: ?

# Usage
Simply create a surface and a buffer that contains data you want to write to the surface. Use **stenSet** to write data to the surface and **stenGet** to read data from the surface into a buffer

# Notes
To prevent the data from being misread, be sure to disable any blending modes whenever rendering to the input surface, if not using `_stenToSurface`

# Example
See the object *oMain* to see a usage example

# Function Reference
*Primary Functions*
### `stenSet( surface, buffer )` 
Embeds the buffer data into the surface and returns the originally passed in surface index

### `stenGet( surface )`
Gets the surface as a buffer and extracts data based on the header, returns a buffer containing the data if success

*Internal Functions*
### `_stenToBuffer( surface )`
Creatse a buffer and copies surface data to it

### `_stenToSurface( sprite_id )`
Creates a surface based on the sprite's size and renders said sprite with no blending to the surface
