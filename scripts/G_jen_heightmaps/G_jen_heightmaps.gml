//Heightmap functions, and noise functions (once added).

//Heightmaps.
#region jen_heightmap_create(width, height);
/// @function jen_heightmap_create
/// @description Creates a new empty heightmap.
/// @param width
/// @param height
function jen_heightmap_create(_width, _height)
{
	var _grid = ds_grid_create(_width, _height);
	ds_grid_clear(_grid, 0);
	return _grid;
}
#endregion
#region jen_heightmap_destroy(heightmap);
/// @function jen_heightmap_destroy
/// @description Destroys a heightmap.
/// @param heightmap
function jen_heightmap_destroy(_heightmap)
{
	ds_grid_destroy(_heightmap);
}
#endregion
#region jen_heightmap_get(heightmap, x1, y1);
/// @function jen_heightmap_get
/// @description Returns the value of a heightmap at a position.
/// @param heightmap
/// @param x1
/// @param y1
function jen_heightmap_get(_heightmap, _x, _y)
{
	//Check if it is out of bounds, otherwise return the value directly.
	if (_x < 0 || _y < 0 || _x >= jen_heightmap_width(_heightmap) || _y >= jen_heightmap_height(_heightmap)) { return undefined; }
	return _heightmap[# _x, _y];
}
#endregion
#region jen_heightmap_set(heightmap, x1, y1, value);
/// @function jen_heightmap_set
/// @description 
/// @param heightmap
/// @param x1
/// @param y1
/// @param value
function jen_heightmap_set(_heightmap, _x, _y, _value)
{
	//Checking if it is out of bounds, otherwise attempt to set the value.
	if (_x < 0 || _y < 0 || _x >= jen_heightmap_width(_heightmap) || _y >= jen_heightmap_height(_heightmap)) { return false; }

	//Setting the new value.
	_heightmap[# _x, _y] = _value;
	return true;
}
#endregion
#region jen_heightmap_width(heightmap);
/// @function jen_heightmap_width
/// @description Returns the width of a heightmap.
/// @param heightmap
function jen_heightmap_width(_heightmap)
{
	return ds_grid_width(_heightmap);
}
#endregion
#region jen_heightmap_height(heightmap);
/// @function jen_heightmap_height
/// @description Returns the height of a jen_heightmap.
/// @param heightmap
function jen_heightmap_height(_heightmap)
{
	return ds_grid_height(_heightmap);
}
#endregion
#region jen_heightmap_draw(heightmap, x1, y1);
/// @function jen_heightmap_draw
/// @description Displays the values of a heightmap.
/// @param heightmap
/// @param x1
/// @param y1
function jen_heightmap_draw(_heightmap, _x1, _y1)
{
	//Getting the width and height of the heightmap.
	var _width = jen_heightmap_width(_heightmap);
	var _height = jen_heightmap_height(_heightmap);
	
	//Drawing each cell of the heightmap.
	var scale = 8;
	for (var yy = 0; yy < _height; yy ++) {
	for (var xx = 0; xx < _width; xx ++)
	{
		draw_set_alpha(jen_heightmap_get(_heightmap, xx, yy));
		draw_rectangle(_x1 + (xx * scale), _y1 + (yy * scale), _x1 + (xx * scale) + scale - 1, _y1 + (yy * scale) + scale - 1, false);
	} }
	draw_set_alpha(1.0);
}
#endregion
#region jen_heightmap_sampling(width, height, radius, iterations);
/// @function jen_heightmap_sampling
/// @description Generates a new heightmap using average sampling.
/// @param width
/// @param height
/// @param range
/// @param iterations
function jen_heightmap_sampling(_width, _height, _range, _iterations)
{
	//Create two new heightmaps.
	var _heightmap_new = jen_heightmap_create(_width, _height);
	var _heightmap_temp = jen_heightmap_create(_width, _height);

	//Fill with random values.
	for (var yy = 0; yy < _height; yy ++) {
	for (var xx = 0; xx < _width; xx ++) {
		jen_heightmap_set(_heightmap_new, xx, yy, irandom(1.0));
	} xx = 0; }

	repeat(_iterations)
	{
		//Loop through finding the average for every position.
		for (var yy = 0; yy < _height; yy ++) {
		for (var xx = 0; xx < _width; xx ++) {
			var val = ds_grid_get_disk_mean(_heightmap_new, xx, yy, _range);
			jen_heightmap_set(_heightmap_temp, xx, yy, val);
		} }
		ds_grid_copy(_heightmap_new, _heightmap_temp);
	}

	//Normalize the final heightmap and return the id.
	ds_grid_destroy(_heightmap_temp);
	jen_heightmap_normalize(_heightmap_new);
	return _heightmap_new;
}
#endregion
#region jen_heightmap_gradient(width, height, radius, density);
/// @function jen_heightmap_gradient
/// @description 
/// @param width
/// @param height
/// @param radius
/// @param density
function jen_heightmap_gradient(_width, _height, _radius, _density)
{
	//Create the empty heightmap.
	var _heightmap = jen_heightmap_create(_width, _height);
	
	//Build a gradient of the appropriate size.
	var _diameter = (_radius * 2) + 1;
	var _gradient = jen_heightmap_create(_diameter, _diameter);
	for (var yy = 0; yy < _diameter; yy++) {
	for (var xx = 0; xx < _diameter; xx++)
	{
		var val = _radius - point_distance(xx, yy, _radius, _radius);
		if (val > 0) { jen_heightmap_set(_gradient, xx, yy, val); }
	} }
	
	//Add radient circles randomly across the heightmap.
	repeat(_density * _width * _height)
	{
		var x1 = irandom_range(-_radius, _width - 1 + _radius);
		var y1 = irandom_range(-_radius, _height - 1 + _radius);
		
		//Loop through each value of the gradient circle.
		for (var yy = 0; yy < _diameter; yy++) {
		for (var xx = 0; xx < _diameter; xx++)
		{
			var val = jen_heightmap_get(_heightmap, x1 - _radius + xx, y1 - _radius + yy);
			if (val != undefined) { jen_heightmap_set(_heightmap, x1 - _radius + xx, y1 - _radius + yy, val + jen_heightmap_get(_gradient, xx, yy)); }
		} }
	}
	
	//Normalize the final result and return.
	jen_heightmap_normalize(_heightmap);
	return _heightmap;
}
#endregion
#region jen_heightmap_apply(grid, heightmap, x1, y1, min, max, replace, new_value, [chance], [function]);
/// @function jen_heightmap_apply
/// @description Converts a range of values in a heightmap to values in a grid.
/// @param grid
/// @param heightmap
/// @param x1
/// @param y1
/// @param min
/// @param max
/// @param replace
/// @param new_value
/// @param [chance]
/// @param [function]
function jen_heightmap_apply(_grid, _heightmap, _x1, _y1, _min, _max, _replace, _new_value, _chance = 100, _function = noone)
{
	//Getting the width and height of the heightmap.
	var _width = jen_heightmap_width(_heightmap);
	var _height = jen_heightmap_height(_heightmap);
	
	//Create a temporary grid for storing the changes.
	var _temp_grid = jen_grid_create(_width, _height, noone);
	
	//Checking each value in the heightmap.
	for (var yy = 0; yy < _height; yy ++) {
	for (var xx = 0; xx < _width; xx ++) {
		var val = jen_heightmap_get(_heightmap, xx, yy);
		if (val >= _min && val <= _max)
		{
			jen_set(_temp_grid, xx, yy, all, _new_value);
		}
	} }
	
	//Apply the changes to the base grid.
	jen_grid_apply(_grid, _temp_grid, _replace, _x1, _y1, _chance, _function);
	jen_grid_destroy(_temp_grid);
}
#endregion
#region jen_heightmap_normalize(heightmap);
/// @function jen_heightmap_normalize
/// @description Maps all values in a heightmap to a scale between 0.0 and 1.0.
/// @param heightmap
function jen_heightmap_normalize(_heightmap)
{
	//Getting the width and height of the heightmap.
	var _width = jen_heightmap_width(_heightmap);
	var _height = jen_heightmap_height(_heightmap);
	
	//Find the maximum and minimum.
	var _max = ds_grid_get_max(_heightmap, 0, 0, _width - 1, _height - 1);
	var _min = ds_grid_get_min(_heightmap, 0, 0, _width - 1, _height - 1);
	
	for (var yy = 0; yy < _height; yy++) {
	for (var xx = 0; xx < _width; xx++)
	{
		var _value = (jen_heightmap_get(_heightmap, xx, yy) - _min) / (_max - _min);
		jen_heightmap_set(_heightmap, xx, yy, _value);
	} }
}
#endregion