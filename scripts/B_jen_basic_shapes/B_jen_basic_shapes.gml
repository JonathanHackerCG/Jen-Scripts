//Basic shape functions. Lines, circle, rectangles, etcetera.

#region jen_line(JenGrid, x1, y1, x2, y2, replace, new_value, [chance], [function]);
/// @func jen_line
/// @desc Creates a line between two points.
/// @arg  {Id.Grid} grid
/// @arg  {Real} x1
/// @arg  {Real} y1
/// @arg  {Real} x2
/// @arg  {Real} y2
/// @arg  {Any} replace
/// @arg  {Any} new_value
/// @arg  {Real} [chance]
/// @arg  {Function} [function]
function jen_line(_grid, _x1, _y1, _x2, _y2, _replace, _new_value, _chance = 100, _function = noone)
{
	//Calculating _step amounts for the line.
	var _xdis = _x2 - _x1;
	var _ydis = _y2 - _y1;
	var _step = max(abs(_xdis), abs(_ydis));
	_xdis = _xdis / _step;
	_ydis = _ydis / _step;
		
	//Creating the line based on total _steps.
	var xx = _x1;
	var yy = _y1;
	var _count = 0;
	while (_count <= _step)
	{
		//Checking first if the position is valid.
		if (_chance >= 100 || random(100) < _chance)
		{
			//Setting the line position/appropriate function.
			if (_function == noone)
			{
				jen_set(_grid, xx, yy, all, _new_value);
			}
			else if (_replace == all || jen_get(_grid, round(xx), round(yy)) == _replace)
			{
				_function(_grid, xx, yy, _replace, _new_value);
			}
		}
		//Increment position.
		xx += _xdis;
		yy += _ydis;
		_count ++;
	}
}
#endregion
#region jen_rectangle(JenGrid, xcell1, ycell1, xcell2, ycell2, replace, new_value, [outline], [chance], [function]);
/// @func jen_rectangle(JenGrid, xcell1, ycell1, xcell2, ycell2, replace, new_value, [outline], [chance], [function]):
/// @desc Creates a rectangle between two positions.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg	{Real}				xcell1
/// @arg	{Real}				ycell1
/// @arg	{Real}				xcell2
/// @arg	{Real}				ycell2
/// @arg	{Any}					replace			Supports Array (Any)
/// @arg	{Any}					new_value		Supports Array (Chooses)
/// @arg	{Real}				[outline]		Default: 0
/// @arg	{Real}				[chance]		Default: 100
/// @arg	{Function}		[function]	Default: noone
function jen_rectangle(_grid, _x1, _y1, _x2, _y2, _replace, _new_value, _outline = 0, _chance = 100, _function = noone)
{
	//Finding corners.
	var _xx1 = min(_x1, _x2);
	var _xx2 = max(_x1, _x2);
	var _yy1 = min(_y1, _y2);
	var _yy2 = max(_y1, _y2);
	
	//Array conversions.
	_replace = _jenternal_convert_replace(_replace);
	
	//Iterate through the grid.
	for (var yy = _yy1; yy <= _yy2; yy++) {
	for (var xx = _xx1; xx <= _xx2; xx++) {
		//Only checking spaces in the rectangle, based on outline.
		var _o = _outline;
		if (!_o || (xx < _xx1 + _o || yy < _yy1 + _o || xx > _xx2 - _o || yy > _yy2 - _o))
		{
			//Random chance and using the appropriate function.
			if (_chance >= 100 || random(100) < _chance)
			{
				if (_function == noone)
				{
					//Replace matching values.
					jen_set(_grid, xx, yy, _replace, _new_value);
				}
				else if (_replace == all || jen_test(_grid, xx, yy, _replace))
				{
					//Run custom function.
					_function(_grid, xx, yy, _replace, _new_value);
				}
			}
		}
		else
		{
			//To skip some unnecessary checks when it is an outline.
			xx = _xx2 - _o;
		}
	} }
}
#endregion
#region jen_triangle(JenGrid, x1, y1, x2, y2, x3, y3, replace, new_value, [chance], [function]);
/// @func jen_triangle
/// @desc This creates a triangle. There is no option for a filled triangle.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg  x1
/// @arg  y1
/// @arg  x2
/// @arg  y2
/// @arg  x3
/// @arg  y3
/// @arg  replace
/// @arg  new_value
/// @arg  [chance]
/// @arg  [function]
function jen_triangle(_grid, _x1, _y1, _x2, _y2, _x3, _y3, _replace, _new_value, _chance = 100, _function = noone)
{
	//Drawing three lines. (That's basically all this function does).
	jen_line(_grid, _x1, _y1, _x2, _y2, _replace, _new_value, _chance, _function);
	jen_line(_grid, _x2, _y2, _x3, _y3, _replace, _new_value, _chance, _function);
	jen_line(_grid, _x3, _y3, _x1, _y1, _replace, _new_value, _chance, _function);
}
#endregion
#region jen_ellipse(JenGrid, x1, y1, haxis, vaxis, replace, new_value, angle, outline, [chance], [function]);
/// @func jen_ellipse
/// @desc Creates an ellipse. Define the length of each axis, and the rotation.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg  x1
/// @arg  y1
/// @arg  haxis
/// @arg  vaxis
/// @arg  replace
/// @arg  new_value
/// @arg  angle
/// @arg  outline
/// @arg  [chance]
/// @arg  [function]
function jen_ellipse(_grid, _x1, _y1, _haxis, _vaxis, _replace, _new_value, _angle, _outline, _chance = 100, _function = noone)
{
	//Getting width and height of the grid.
	var _w = jen_grid_width(_grid);
	var _h = jen_grid_height(_grid);
	
	//Estimating the required increment.
	var _increment = 90 / (2 * pi * max(_haxis, _vaxis));
	var _temp_grid = jen_grid_create(_width, _height, noone);
	var xx = 0; var yy = 0;
	
	//Looping around the course of the ellipse and setting values.
	for (var theta = 0; theta <= 360; theta += _increment)
	{
		xx = (_haxis * dcos(theta) * dcos(_angle)) - (_vaxis * dsin(theta) * dsin(_angle));
		yy = (_haxis * dcos(theta) * dsin(_angle)) + (_vaxis * dsin(theta) * dcos(_angle));
		
		//Creating the ellipse in the temporary grid.
		jen_set(_temp_grid, round(_x1 + xx), round(_y1 + yy), all, "_jenternal_undefined");
		if (!_outline) { jen_line(_temp_grid, _x1 + xx, _y1 + yy, _x1, _y1, all, "_jenternal_undefined"); }
	}
	
	//Applying the temporary grid over the base grid.
	jen_grid_apply(_grid, _temp_grid, _replace, 0, 0, _chance, _function);
	jen_replace(_grid, "_jenternal_undefined", _new_value);
	
	//Clearing memory.
	jen_grid_destroy(_temp_grid);
}
#endregion
#region jen_fill(JenGrid, x1, y1, replace, new_value, diagonal);
/// @func jen_fill
/// @desc Fills a space of matching values. May cross diagonals or not.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg  x1
/// @arg  y1
/// @arg  replace
/// @arg  new_value
/// @arg  diagonal
function jen_fill(_grid, xx, yy, _replace, _new_value, _diagonal)
{
	//Attempt to set the starting position. Only runs if this part works.
	if (jen_set(_grid, xx, yy, _replace, _new_value))
	{
		//Create a queue to keep track of every position to fill.
		var _Qx = ds_queue_create();
		var _Qy = ds_queue_create();
		
		//Add the initial point to the queue.
		ds_queue_enqueue(_Qx, xx);
		ds_queue_enqueue(_Qy, yy);
		
		//In theory, the x and y queue should always be the same size.
		while (ds_queue_size(_Qx) != 0)
		{
			//Get the top point in the queue.
			xx = ds_queue_dequeue(_Qx);
			yy = ds_queue_dequeue(_Qy);
			
			//Check for fillable positions in each direction and add them to the queue.
			#region Right/Up/Left/Down
			if (jen_set(_grid, xx + 1, yy, _replace, _new_value))
			{
				ds_queue_enqueue(_Qx, xx + 1);
				ds_queue_enqueue(_Qy, yy);
			}
			if (jen_set(_grid, xx, yy - 1, _replace, _new_value))
			{
				ds_queue_enqueue(_Qx, xx);
				ds_queue_enqueue(_Qy, yy - 1);
			}
			if (jen_set(_grid, xx - 1, yy, _replace, _new_value))
			{
				ds_queue_enqueue(_Qx, xx - 1);
				ds_queue_enqueue(_Qy, yy);
			}
			if (jen_set(_grid, xx, yy + 1, _replace, _new_value))
			{
				ds_queue_enqueue(_Qx, xx);
				ds_queue_enqueue(_Qy, yy + 1);
			}
			#endregion
			#region Diagonals
			if (_diagonal)
			{
				if (jen_set(_grid, xx + 1, yy + 1, _replace, _new_value))
				{
					ds_queue_enqueue(_Qx, xx + 1);
					ds_queue_enqueue(_Qy, yy + 1);
				}
				if (jen_set(_grid, xx + 1, yy - 1, _replace, _new_value))
				{
					ds_queue_enqueue(_Qx, xx + 1);
					ds_queue_enqueue(_Qy, yy - 1);
				}
				if (jen_set(_grid, xx - 1, yy - 1, _replace, _new_value))
				{
					ds_queue_enqueue(_Qx, xx - 1);
					ds_queue_enqueue(_Qy, yy - 1);
				}
				if (jen_set(_grid, xx - 1, yy + 1, _replace, _new_value))
				{
					ds_queue_enqueue(_Qx, xx - 1);
					ds_queue_enqueue(_Qy, yy + 1);
				}
			}
			#endregion
		}
		
		//Clearing memory.
		ds_queue_destroy(_Qx);
		ds_queue_destroy(_Qy);
	}
}
#endregion