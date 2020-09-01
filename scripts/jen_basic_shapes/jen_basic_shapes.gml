//Basic shape functions. Lines, circle, rectangles, etcetera.

#region jen_line(grid, x1, y1, x2, y2, replace, new_value, [chance], [function]);
/// @description Creates a line between two points.
/// @param grid
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param replace
/// @param new_value
/// @param [chance]
/// @param [function]
function jen_line(_grid, _x1, _y1, _x2, _y2, _replace, _new_value, _chance, _function)
{
	//Get optional parameters.
	if (is_undefined(_chance)) { _chance = 100; }
	if (is_undefined(_function)) { _function = noone; }
	
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
#region jen_rectangle(grid, x1, y1, x2, y2, replace, new_value, outline, [chance], [function]);
/// @description Creates a rectangle between two positions.
/// @param grid
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param replace
/// @param new_value
/// @param outline
/// @param [chance]
/// @param [function]
function jen_rectangle(_grid, _x1, _y1, _x2, _y2, _replace, _new_value, _outline, _chance, _function)
{
	//Get optional parameters.
	if (is_undefined(_chance)) { _chance = 100; }
	if (is_undefined(_function)) { _function = noone; }
	
	//Iterate through the grid.
	for (var yy = _y1; yy <= _y2; yy++) {
	for (var xx = _x1; xx <= _x2; xx++)
	{
		//Only checking spaces in the rectangle, based on outline.
		if (!_outline || (xx == _x1 || xx == _x2 || yy == _y1 || yy == _y2))
		{
			//Random chance and using the appropriate function.
			if (random(100) < _chance)
			{
				if (_function == noone)
				{
					//Replace matching values.
					jen_set(_grid, xx, yy, _replace, _new_value);
				}
				else if (_replace == all || jen_get(_grid, xx, yy) == _replace)
				{
					//Run custom function.
					_function(_grid, xx, yy, _replace, _new_value);
				}
			}
		}
		else
		{
			//To skip some unnecessary checks when it is an outline.
			xx = _x2 - 1;
		}
	} }
}
#endregion
#region jen_triangle(grid, x1, y1, x2, y2, x3, y3, replace, new_value, [chance], [function]);
/// @description This creates a triangle. There is no option for a filled triangle.
/// @param grid
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param x3
/// @param y3
/// @param replace
/// @param new_value
/// @param [chance]
/// @param [function]
function jen_triangle(_grid, _x1, _y1, _x2, _y2, _x3, _y3, _replace, _new_value, _chance, _function)
{
	//Get optional parameters.
	if (is_undefined(_chance)) { _chance = 100; }
	if (is_undefined(_function)) { _function = noone; }
	
	//Drawing three lines. (That's basically all this function does).
	jen_line(_grid, _x1, _y1, _x2, _y2, _replace, _new_value, _chance, _function);
	jen_line(_grid, _x2, _y2, _x3, _y3, _replace, _new_value, _chance, _function);
	jen_line(_grid, _x3, _y3, _x1, _y1, _replace, _new_value, _chance, _function);
}
#endregion
#region jen_ellipse(grid, x1, y1, haxis, vaxis, replace, new_value, angle, outline, [chance], [function]);
/// @description Creates an ellipse. Define the length of each axis, and the rotation.
/// @param grid
/// @param x1
/// @param y1
/// @param haxis
/// @param vaxis
/// @param replace
/// @param new_value
/// @param angle
/// @param outline
/// @param [chance]
/// @param [function]
function jen_ellipse(_grid, _x1, _y1, _haxis, _vaxis, _replace, _new_value, _angle, _outline, _chance, _function)
{
	//Get optional parameters.
	if (is_undefined(_chance)) { _chance = 100; }
	if (is_undefined(_function)) { _function = noone; }
	
	//Getting width and height of the grid.
	var _width = jen_grid_width(_grid);
	var _height = jen_grid_height(_grid);
	
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
		jen_set(_temp_grid, round(_x1 + xx), round(_y1 + yy), all, _new_value);
		if (!_outline) { jen_line(_temp_grid, _x1 + xx, _y1 + yy, _x1, _y1, all, _new_value); }
	}
	
	//Applying the temporary grid over the base grid.
	if (_function == noone)	{	jen_grid_apply(_grid, _temp_grid, _replace, 0, 0, _chance);	}
	else { jen_grid_apply(_grid, _temp_grid, _replace, 0, 0, _chance, _function); }
	
	//Clearing memory.
	jen_grid_destroy(_temp_grid);
}
#endregion
#region jen_fill(grid, x1, y1, replace, new_value, diagonal);
/// @description Fills a space of matching values. May cross diagonals or not.
/// @param grid
/// @param x1
/// @param y1
/// @param replace
/// @param new_value
/// @param diagonal
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