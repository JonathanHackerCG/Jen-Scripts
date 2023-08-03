//Basic shape functions. Lines, circle, rectangles, etcetera.

//Primitive shapes.
#region jen_line(JenGrid, x1, y1, x2, y2, replace, new_value, [chance], [setter]);
/// @func jen_line(JenGrid, x1, y1, x2, y2, replace, new_value, [chance], [setter]):
/// @desc Creates a line between two points.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg  {Real}				x1
/// @arg  {Real}				y1
/// @arg  {Real}				x2
/// @arg  {Real}				y2
/// @arg	{Any}					replace			Supports Array (Any)
/// @arg	{Any}					new_value		Supports Array (Chooses)
/// @arg	{Real}				[chance]		Default: 100
/// @arg	{Function}		[setter]		Default: jen_set
function jen_line(_grid, _x1, _y1, _x2, _y2, _replace, _new_value, _chance = 100, _setter = jen_set)
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
			_setter(_grid, round(xx), round(yy), _replace, _new_value);
		}
		//Increment position.
		xx += _xdis;
		yy += _ydis;
		_count ++;
	}
}
#endregion
#region jen_rectangle(JenGrid, xcell1, ycell1, xcell2, ycell2, replace, new_value, [outline], [chance], [setter]);
/// @func jen_rectangle(JenGrid, xcell1, ycell1, xcell2, ycell2, replace, new_value, [outline], [chance], [setter]):
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
/// @arg	{Function}		[setter]		Default: jen_set
function jen_rectangle(_grid, _x1, _y1, _x2, _y2, _replace, _new_value, _outline = 0, _chance = 100, _setter = jen_set)
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
				_setter(_grid, xx, yy, _replace, _new_value);
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
#region jen_triangle(JenGrid, x1, y1, x2, y2, x3, y3, replace, new_value, [chance], [setter]);
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
/// @arg  [setter]	
function jen_triangle(_grid, _x1, _y1, _x2, _y2, _x3, _y3, _replace, _new_value, _chance = 100, _setter = jen_set)
{
	//Drawing three lines. (That's basically all this function does).
	jen_line(_grid, _x1, _y1, _x2, _y2, _replace, _new_value, _chance, _setter);
	jen_line(_grid, _x2, _y2, _x3, _y3, _replace, _new_value, _chance, _setter);
	jen_line(_grid, _x3, _y3, _x1, _y1, _replace, _new_value, _chance, _setter);
}
#endregion
//TO ADD: jen_polygon???
//TO ADD: jen_circle(JenGrid, x1, y1, radius, replace, new_value, [outline], [chance], [setter]);
#region jen_ellipse(JenGrid, x1, y1, haxis, vaxis, replace, new_value, angle, outline, [chance], [setter]);
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
/// @arg  [setter]	
function jen_ellipse(_grid, _x1, _y1, _haxis, _vaxis, _replace, _new_value, _angle, _outline, _chance = 100, _setter = jen_set)
{
	//Getting width and height of the grid.
	var _w = jen_grid_width(_grid);
	var _h = jen_grid_height(_grid);
	
	//Estimating the required increment.
	var _increment = 90 / (2 * pi * max(_haxis, _vaxis));
	var _temp_grid = jen_grid_create(_w, _h, noone);
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
	jen_grid_paste(_grid, _temp_grid, _replace, 0, 0, _chance, _setter);
	jen_replace(_grid, "_jenternal_undefined", _new_value);
	
	//Clearing memory.
	jen_grid_destroy(_temp_grid);
}
#endregion

//Wandering lines.
#region jen_wander_direction(JenGrid, x1, y1, initial_angle, correction_count, correction_accuracy, adjustment_count, adjustment_accuracy, lifetime, replace, new_value, [chance], [setter]);
/// @func jen_wander_direction
/// @desc Will create a wandering line between two positions.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg  x1
/// @arg  y1
/// @arg  initial_angle
/// @arg  correction_count
/// @arg  correction_accuracy
/// @arg  adjustment_count
/// @arg  adjustment_accuracy
/// @arg  lifetime
/// @arg  replace
/// @arg  new_value
/// @arg  [chance]
/// @arg  [setter]	
function jen_wander_direction(_grid, _x1, _y1, _initial_angle, _correction_count, _correction_accuracy, _adjustment_count, _adjustment_accuracy, _lifetime, _replace, _new_value, _chance = 100, _setter = undefined)
{
	//Execute the wandering.
	var _count = 0; var xx = _x1; var yy = _y1;
	var _angle = _initial_angle + irandom_range(-_correction_accuracy, _correction_accuracy);
	repeat(_lifetime)
	{
		//Set the value for that new position.
		if (_chance >= 100 || random(100) < _chance)
		{
			//TODO: Update to use jen_set as default _setter parameter.
			if (_setter == undefined)
			{
				//Directly set the target value to the application value.
				jen_set(_grid, round(xx), round(yy), _replace, _new_value);
			}
			else if (_replace == all || jen_get(_grid, round(xx), round(yy)) == _replace)
			{
				_setter(_grid, round(xx), round(yy), _replace, _new_value);
			}
		}
		
		//Updating primary angle.
		if (_correction_count == 0 || _count % _correction_count == 0)
		{
			_angle = _initial_angle + irandom_range(-_correction_accuracy, _correction_accuracy);
		}
		//Updating movement angle.
		if (_adjustment_count == 0 || _count % _adjustment_count == 0)
		{
			var _angle_off = irandom_range(-_adjustment_accuracy, _adjustment_accuracy);
		}
		_angle += _angle_off;
		
		//Calculating a new position.
		xx += lengthdir_x(1, _angle);
		yy += lengthdir_y(1, _angle);

		_count++; //Increment the count.
	}
}
#endregion
#region jen_wander_line(JenGrid, x1, y1, x2, y2, correction_count, correction_accuracy, adjustment_count, adjustment_accuracy, lifetime, replace, new_value, [chance], [setter]);
/// @func jen_wander_line
/// @desc Will create a wandering line between two positions.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg  x1
/// @arg  y1
/// @arg  x2
/// @arg  y2
/// @arg  correction_count
/// @arg  correction_accuracy
/// @arg  adjustment_count
/// @arg  adjustment_accuracy
/// @arg  lifetime
/// @arg  replace
/// @arg  new_value
/// @arg  [chance]
/// @arg  [setter]	
function jen_wander_line(_grid, _x1, _y1, _x2, _y2, _correction_count, _correction_accuracy, _adjustment_count, _adjustment_accuracy, _lifetime, _replace, _new_value, _chance = 100, _setter = jen_set)
{
	//Execute the wandering.
	var _count = 0; var xx = _x1; var yy = _y1;
	var _angle = point_direction(_x1, _y1, _x2, _y2) + irandom_range(-_correction_accuracy, _correction_accuracy);
	repeat(_lifetime)
	{
		//Set the value for that new position.
		if (_chance >= 100 || random(100) < _chance)
		{
			//TODO: Update to use jen_set as default _setter parameter.
			if (_setter == undefined)
			{
				//Directly set the target value to the application value.
				jen_set(_grid, round(xx), round(yy), _replace, _new_value);
			}
			else if (_replace == all || jen_get(_grid, round(xx), round(yy)) == _replace)
			{
				_setter(_grid, round(xx), round(yy), _replace, _new_value);
			}
		}
		
		//Updating primary angle.
		if (_correction_count == 0 || _count % _correction_count == 0)
		{
			_angle = point_direction(xx, yy, _x2, _y2) + irandom_range(-_correction_accuracy, _correction_accuracy);
		}
		//Updating movement angle.
		if (_adjustment_count == 0 || _count % _adjustment_count == 0)
		{
			var _angle_off = irandom_range(-_adjustment_accuracy, _adjustment_accuracy);
		}
		
		//Moving directly to the target.
		if (point_distance(xx, yy, _x2, _y2) <= max(_correction_count, _adjustment_count))
		{
			_angle = point_direction(xx, yy, _x2, _y2);
		}
		
		_angle += _angle_off;
		
		//Calculating a new position.
		xx += lengthdir_x(1, _angle);
		yy += lengthdir_y(1, _angle);
		
		_count++; //Increment the count.
		
		//Exit early if it has reached the destination.
		if (point_distance(xx, yy, _x2, _y2) <= 0.5) { exit; }
	}
}
#endregion