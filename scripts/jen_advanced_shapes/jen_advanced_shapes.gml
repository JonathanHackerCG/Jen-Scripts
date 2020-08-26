//Advanced shapes, wandering lines and mazes.

//Wandering lines.
#region jen_wander_direction(maze, x1, y1, initial_angle, correction_count, correction_accuracy, adjustment_count, adjustment_accuracy, lifetime, replace, new_value, [chance], [function]);
/// @description Will create a wandering line between two positions.
/// @param maze
/// @param x1
/// @param y1
/// @param initial_angle
/// @param correction_count
/// @param correction_accuracy
/// @param adjustment_count
/// @param adjustment_accuracy
/// @param lifetime
/// @param replace
/// @param new_value
/// @param [chance]
/// @param [function]
function jen_wander_direction(_grid, _x1, _y1, _initial_angle, _correction_count, _correction_accuracy, _adjustment_count, _adjustment_accuracy, _lifetime, _replace, _new_value, _chance, _function)
{
	//Get optional parameters.
	if (is_undefined(_chance)) { _chance = 100; }
	if (is_undefined(_function)) { _function = noone; }
	else
	{
		info = {};
		info.x1 = _x1; info.y1 = _y1;
		info.chance = _chance;
		info.initial_angle = _initial_angle;
		info.correction_count = _correction_count;
		info.correction_accuracy = _correction_accuracy;
		info.adjustment_count = _adjustment_count;
		info.adjustment_accuracy = _adjustment_accuracy;
		info.lifetime = _lifetime;
	}
	
	//Execute the wandering.
	var _count = 0; var xx = _x1; var yy = _y1;
	var _angle = _initial_angle + irandom_range(-_correction_accuracy, _correction_accuracy);
	repeat(_lifetime)
	{
		//Set the value for that new position.
		if (_chance >= 100 || random(100) < _chance)
		{
			if (_function == noone)
			{
				//Directly set the target value to the application value.
				jen_set(_grid, round(xx), round(yy), _replace, _new_value);
			}
			else if (_replace == all || jen_get(_grid, round(xx), round(yy)) == _replace)
			{
				//Run the custom function.
				_function(_grid, round(xx), round(yy), _replace, _new_value, info);
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
#region jen_wander_line(maze, x1, y1, x2, y2, correction_count, correction_accuracy, adjustment_count, adjustment_accuracy, lifetime, replace, new_value, [chance], [function]);
/// @description Will create a wandering line between two positions.
/// @param maze
/// @param x1
/// @param y1
/// @param x2
/// @param y2
/// @param correction_count
/// @param correction_accuracy
/// @param adjustment_count
/// @param adjustment_accuracy
/// @param lifetime
/// @param replace
/// @param new_value
/// @param [chance]
/// @param [function]
function jen_wander_line(_grid, _x1, _y1, _x2, _y2, _correction_count, _correction_accuracy, _adjustment_count, _adjustment_accuracy, _lifetime, _replace, _new_value, _chance, _function)
{
	//Get optional parameters.
	if (is_undefined(_chance)) { _chance = 100; }
	if (is_undefined(_function)) { _function = noone; }
	else
	{
		info = {};
		info.x1 = _x1; info.y1 = _y1;
		info.x2 = _x2; info.y2 = _y2;
		info.chance = _chance;
		info.correction_count = _correction_count;
		info.correction_accuracy = _correction_accuracy;
		info.adjustment_count = _adjustment_count;
		info.adjustment_accuracy = _adjustment_accuracy;
		info.lifetime = _lifetime;
	}
	
	//Execute the wandering.
	var _count = 0; var xx = _x1; var yy = _y1;
	var _angle = point_direction(_x1, _y1, _x2, _y2) + irandom_range(-_correction_accuracy, _correction_accuracy);
	repeat(_lifetime)
	{
		//Set the value for that new position.
		if (_chance >= 100 || random(100) < _chance)
		{
			if (_function == noone)
			{
				//Directly set the target value to the application value.
				jen_set(_grid, round(xx), round(yy), _replace, _new_value);
			}
			else if (_replace == all || jen_get(_grid, round(xx), round(yy)) == _replace)
			{
				//Run the custom function.
				_function(_grid, round(xx), round(yy), _replace, _new_value, info);
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

//Maze generation.
#region jen_maze_create(width, height);
/// @description Creates a blank maze. Mostly for internal use.
/// @param width
/// @param height
function jen_maze_create(_width, _height)
{
	var _grid = ds_grid_create(_width, _height);
	ds_grid_clear(_grid, 0);
	return _grid;
}
#endregion
#region jen_maze_destroy(maze);
/// @description Destroy a maze grid.
/// @param maze
function jen_maze_destroy(_maze)
{
	ds_grid_destroy(_maze);
}
#endregion
#region jen_maze_get(maze, x1, y1, jen_dir);
/// @description Returns true/false if a particular direction is connected.
/// @param maze
/// @param x1
/// @param y1
/// @param jen_dir
function jen_maze_get(_maze, _x1, _y1, _dir)
{
	switch(_dir)
	{
		case jen_dir.R: { return _maze[# _x1, _y1] & 1; } break;
		case jen_dir.U: { return _maze[# _x1, _y1] & 2; } break;
		case jen_dir.L: { return _maze[# _x1, _y1] & 4; } break;
		case jen_dir.D: { return _maze[# _x1, _y1] & 8; } break;
	}
}
#endregion
#region jen_maze_set(maze, x1, y1, jen_dir, connected);
/// @description Sets a particular direction to be connected (true/false).
/// @param maze
/// @param x1
/// @param y1
/// @param jen_dir
/// @param connected
function jen_maze_set(_maze, _x1, _y1, _dir, _connected)
{
	if (_connected)
	{
		//Setting values to true.
		switch(_dir)
		{
			case jen_dir.R: { _maze[# _x1, _y1] = _maze[# _x1, _y1] | 1; } break;
			case jen_dir.U: { _maze[# _x1, _y1] = _maze[# _x1, _y1] | 2; } break;
			case jen_dir.L: { _maze[# _x1, _y1] = _maze[# _x1, _y1] | 4; } break;
			case jen_dir.D: { _maze[# _x1, _y1] = _maze[# _x1, _y1] | 8; } break;
		}
	}
	else
	{
		//Setting values to false.
		switch(_dir)
		{
			case jen_dir.R: { _maze[# _x1, _y1] = _maze[# _x1, _y1] & ~1; } break;
			case jen_dir.U: { _maze[# _x1, _y1] = _maze[# _x1, _y1] & ~2; } break;
			case jen_dir.L: { _maze[# _x1, _y1] = _maze[# _x1, _y1] & ~4; } break;
			case jen_dir.D: { _maze[# _x1, _y1] = _maze[# _x1, _y1] & ~8; } break;
		}
	}
}
#endregion
#region jen_maze_prim(width, height);
/// @description Creates a new maze using Prim's algorithm.
/// @param width
/// @param height
function jen_maze_prim(_width, _height)
{
	//Create an empty maze to fill with the new maze.
	var _grid = jen_maze_create(_width, _height);

	//Create the queues for storing positions
	var Qx = ds_list_create();
	var Qy = ds_list_create();

	//Initial Starting Point
	var xx = irandom(_width - 1);
	var yy = irandom(_height - 1);

	ds_list_add(Qx, xx);
	ds_list_add(Qy, yy);

	while (ds_list_size(Qx) >= 1)
	{
		//Choose a new random position from among the list
		var pos = irandom(ds_list_size(Qx) - 1);
		xx = Qx[| pos];
		yy = Qy[| pos];
	
		//If all surrounding positions are filled.
		var check = 0;
		if (xx < _width - 1) { if (_grid[# xx + 1, yy] != 0) { check ++; } } else { check ++; }
		if (yy > 0) { if (_grid[# xx, yy - 1] != 0) { check ++; } } else { check ++; }
		if (xx > 0) { if (_grid[# xx - 1, yy] != 0) { check ++; } } else { check ++; }
		if (yy < _height - 1) { if (_grid[# xx, yy + 1] != 0) { check ++; } } else { check ++; }
		if (check == 4)
		{
			ds_list_delete(Qx, pos);
			ds_list_delete(Qy, pos);
		}
		else //There is an open position.
		{
			var chance = irandom(3);
			if (chance == 0 && xx < _width - 1 && _grid[# xx + 1, yy] == 0) //RIGHT (And not at edge or to left of filled tile)
			{
				jen_maze_set(_grid, xx, yy, jen_dir.R, true);
				jen_maze_set(_grid, xx + 1, yy, jen_dir.L, true);
				ds_list_add(Qx, xx + 1);
				ds_list_add(Qy, yy);
			}
			else if (chance == 1 && yy > 0 && _grid[# xx, yy - 1] == 0) //UP (And not at edge or under a filled tile)
			{
				jen_maze_set(_grid, xx, yy, jen_dir.U, true);
				jen_maze_set(_grid, xx, yy - 1, jen_dir.D, true);
				ds_list_add(Qx, xx);
				ds_list_add(Qy, yy - 1);
			}
			else if (chance == 2 && xx > 0 && _grid[# xx - 1, yy] == 0) //LEFT (And not at edge or to right of filled tile)
			{
				jen_maze_set(_grid, xx, yy, jen_dir.L, true);
				jen_maze_set(_grid, xx - 1, yy, jen_dir.R, true);
				ds_list_add(Qx, xx - 1);
				ds_list_add(Qy, yy);
			}
			else if (chance == 3 && yy < _height - 1 && _grid[# xx, yy + 1] == 0) //DOWN (And not at edge or above filled tile)
			{
				jen_maze_set(_grid, xx, yy, jen_dir.D, true);
				jen_maze_set(_grid, xx, yy + 1, jen_dir.U, true);
				ds_list_add(Qx, xx);
				ds_list_add(Qy, yy + 1);
			}
		}
	}

	//Destroy unneeded data structures.
	ds_list_destroy(Qx);
	ds_list_destroy(Qy);

	return _grid;
}
#endregion
#region jen_maze_backtrack(width, height);
/// @description Creates a new maze using Recursive Backtrack algorithm.
/// @param width
/// @param height
function jen_maze_backtrack(_width, _height)
{
	//Create an empty maze to fill.
	var _grid = jen_maze_create(_width, _height);

	//Create the queues for storing positions
	var Qx = ds_list_create();
	var Qy = ds_list_create();
	var Qlist = ds_list_create();

	//Initial Starting Point
	var xx = irandom(_width - 1);
	var yy = irandom(_height - 1);

	var init = false;
	while (ds_list_size(Qx) >= 1 || !init)
	{
		init = true;
	
		//If all surrounding positions are filled. Also, add open positions to the Qlist.
		var check = 0;
		ds_list_clear(Qlist);
		if (xx < _width - 1) { if (_grid[# xx + 1, yy] != 0) { check ++; } else { ds_list_add(Qlist, 1); } } else { check ++; }
		if (yy > 0) { if (_grid[# xx, yy - 1] != 0) { check ++; } else { ds_list_add(Qlist, 2); } } else { check ++; }
		if (xx > 0) { if (_grid[# xx - 1, yy] != 0) { check ++; } else { ds_list_add(Qlist, 3); } } else { check ++; }
		if (yy < _height - 1) { if (_grid[# xx, yy + 1] != 0) { check ++; } else { ds_list_add(Qlist, 4); } } else { check ++; }
		if (check == 4) //There is no surrounding options
		{
			xx = Qx[| ds_list_size(Qy) - 1];
			yy = Qy[| ds_list_size(Qy) - 1];
			ds_list_delete(Qx, ds_list_size(Qx) - 1);
			ds_list_delete(Qy, ds_list_size(Qy) - 1);
		}
		else //At least one unvisited neighbor cell.
		{
			//Add this current cell to the list.
			ds_list_add(Qx, xx);
			ds_list_add(Qy, yy);
		
			//Connect this cell with a random adjacent cell.
			var value = Qlist[| irandom(ds_list_size(Qlist) - 1)];
			if (value == 1)
			{
				jen_maze_set(_grid, xx, yy, jen_dir.R, true);
				jen_maze_set(_grid, xx + 1, yy, jen_dir.L, true);
				xx ++;
			}
			else if (value == 2)
			{
				jen_maze_set(_grid, xx, yy, jen_dir.U, true);
				jen_maze_set(_grid, xx, yy - 1, jen_dir.D, true);
				yy --;
			}
			else if (value == 3)
			{
				jen_maze_set(_grid, xx, yy, jen_dir.L, true);
				jen_maze_set(_grid, xx - 1, yy, jen_dir.R, true);
				xx --;
			}
			else if (value == 4)
			{
				jen_maze_set(_grid, xx, yy, jen_dir.D, true);
				jen_maze_set(_grid, xx, yy + 1, jen_dir.U, true);
				yy ++;
			}
		}
	}

	//Destroy unneeded data structures.
	ds_list_destroy(Qx);
	ds_list_destroy(Qy);
	ds_list_destroy(Qlist);

	return _grid;
}
#endregion
#region jen_maze_draw(maze, x1, y1);
/// @description Draws the layout of a maze grid.
/// @param maze
/// @param x1
/// @param y1
function jen_maze_draw(_maze, _x1, _y1)
{
	//Getting the width and height of the grid.
	var _height = ds_grid_height(_maze);
	var _width = ds_grid_width(_maze);
	
	for (var yy = 0; yy < _height; yy++) {
	for (var xx = 0; xx < _width; xx++)
	{
		if (_maze[# xx, yy] >= 0)
		{
			draw_sprite(_spr_jenternal_maze, _maze[# xx, yy], _x1 + (xx * 16), _y1 + (yy * 16));
		}
	} }
}
#endregion
#region jen_maze_exits(maze, edge_buffer_min, edge_buffer_max, numU, numR, numD, numL);
/// @description Adds exits on the edges of a maze.
/// @param maze
/// @param edge_buffer_min
/// @param edge_buffer_max
/// @param numU
/// @param numR
/// @param numD
/// @param numL
function jen_maze_exits(_maze, _edge_bufferL, _edge_bufferR, _numU, _numR, _numD, _numL)
{
	//Getting width and height of the grid.
	var _width = ds_grid_width(_maze);
	var _height = ds_grid_height(_maze);	
	
	#region UP
	if (_numU > 0)
	{
		//Create a list of each valid position.
		var _list = ds_list_create();
		for (var i = _edge_bufferL; i < _width - _edge_bufferR; i++)
		{
			ds_list_add(_list, i);
		}
		ds_list_shuffle(_list);
		
		//Set exits at random positions.
		var size = ds_list_size(_list);
		for (var i = 0; i < min(_numU, size); i++)
		{
			jen_maze_set(_maze, _list[| i], 0, jen_dir.U, true);
		}
		
		//Destroy the list.
		ds_list_destroy(_list);
	}
	#endregion
	#region RIGHT
	if (_numR > 0)
	{
		//Create a list of each valid position.
		var _list = ds_list_create();
		for (var i = _edge_bufferL; i < _height - _edge_bufferR; i++)
		{
			ds_list_add(_list, i);
		}
		ds_list_shuffle(_list);
		
		//Set exits at random positions.
		var size = ds_list_size(_list);
		for (var i = 0; i < min(_numR, size); i++)
		{
			jen_maze_set(_maze, _width - 1, _list[| i], jen_dir.R, true);
		}
		
		//Destroy the list.
		ds_list_destroy(_list);
	}
	#endregion
	#region DOWN
	if (_numD > 0)
	{
		//Create a list of each valid position.
		var _list = ds_list_create();
		for (var i = _edge_bufferL; i < _width - _edge_bufferR; i++)
		{
			ds_list_add(_list, i);
		}
		ds_list_shuffle(_list);
		
		//Set exits at random positions.
		var size = ds_list_size(_list);
		for (var i = 0; i < min(_numD, size); i++)
		{
			jen_maze_set(_maze, _list[| i], _height - 1, jen_dir.D, true);
		}
		
		//Destroy the list.
		ds_list_destroy(_list);
	}
	#endregion
	#region LEFT
	if (_numL > 0)
	{
		//Create a list of each valid position.
		var _list = ds_list_create();
		for (var i = _edge_bufferL; i < _height - _edge_bufferR; i++)
		{
			ds_list_add(_list, i);
		}
		ds_list_shuffle(_list);
		
		//Set exits at random positions.
		var size = ds_list_size(_list);
		for (var i = 0; i < min(_numL, size); i++)
		{
			jen_maze_set(_maze, 0, _list[| i], jen_dir.L, true);
		}
		
		//Destroy the list.
		ds_list_destroy(_list);
	}
	#endregion
}
#endregion