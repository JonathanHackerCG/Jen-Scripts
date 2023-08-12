//Maze generation, including creation, modification, and instantiation.

//Initialization
#region jen_maze_create(width, height);
/// @func jen_maze_create
/// @desc Creates a blank maze. Mostly for internal use.
/// @arg  width
/// @arg  height
function jen_maze_create(_width, _height)
{
	var _grid = ds_grid_create(_width, _height);
	ds_grid_clear(_grid, 0);
	return _grid;
}
#endregion
#region jen_maze_destroy(maze);
/// @func jen_maze_destroy
/// @desc Destroy a maze grid.
/// @arg  maze
function jen_maze_destroy(_maze)
{
	ds_grid_destroy(_maze);
}
#endregion
//TODO: jen_maze_exists(maze);

//Getters/Setters
#region jen_maze_get(maze, x1, y1, jen_dir);
/// @func jen_maze_get
/// @desc Returns true/false if a particular direction is connected.
/// @arg  maze
/// @arg  x1
/// @arg  y1
/// @arg  jen_dir
function jen_maze_get(_maze, _x1, _y1, _dir)
{
	switch(_dir)
	{
		case jen_dir.R: { return (_maze[# _x1, _y1] & 1) != 0; } break;
		case jen_dir.U: { return (_maze[# _x1, _y1] & 2) != 0; } break;
		case jen_dir.L: { return (_maze[# _x1, _y1] & 4) != 0; } break;
		case jen_dir.D: { return (_maze[# _x1, _y1] & 8) != 0; } break;
	}
}
#endregion
#region jen_maze_set(maze, x1, y1, jen_dir, connected);
/// @func jen_maze_set
/// @desc Sets a particular direction to be connected (true/false).
/// @arg  maze
/// @arg  x1
/// @arg  y1
/// @arg  jen_dir
/// @arg  connected
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
#region jen_maze_width(maze);
/// @func jen_maze_width
/// @desc Returns the width of a maze.
/// @arg  maze
function jen_maze_width(_maze)
{
	return ds_grid_width(_maze);
}
#endregion
#region jen_maze_height(maze);
/// @func jen_maze_height
/// @desc Returns the height of a jen_maze.
/// @arg  maze
function jen_maze_height(_maze)
{
	return ds_grid_height(_maze);
}
#endregion

//Maze creation/modification.
#region jen_maze_prim(width, height);
/// @func jen_maze_prim
/// @desc Creates a new maze using Prim's algorithm.
/// @arg  width
/// @arg  height
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
/// @func jen_maze_backtrack
/// @desc Creates a new maze using Recursive Backtrack algorithm.
/// @arg  width
/// @arg  height
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
#region jen_maze_exits(maze, edge_buffer_min, edge_buffer_max, numU, numR, numD, numL);
/// @func jen_maze_exits
/// @desc Adds exits on the edges of a maze.
/// @arg  maze
/// @arg  edge_buffer_min
/// @arg  edge_buffer_max
/// @arg  numU
/// @arg  numR
/// @arg  numD
/// @arg  numL
function jen_maze_exits(_maze, _edge_bufferL, _edge_bufferR, _numU, _numR, _numD, _numL)
{
	//Getting width and height of the grid.
	var _width = jen_maze_width(_maze);
	var _height = jen_maze_height(_maze);	
	
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

//Maze building.
#region jen_maze_build(maze, value, room_w, room_h, wall_w, wall_h, door_w, door_h);
/// @func jen_maze_build
/// @desc Will create a new jen_grid with walls based on provided jen_maze.
/// @arg  maze
/// @arg  value
/// @arg  room_w
/// @arg  room_h
/// @arg  wall_w
/// @arg  wall_h
/// @arg  door_w
/// @arg  door_h
function jen_maze_build(_maze, _value, _room_w, _room_h, _wall_w, _wall_h, _door_w, _door_h)
{
	//Various width/height calculations.
	var _width_maze = jen_maze_width(_maze);
	var _height_maze = jen_maze_height(_maze);
	var _width = ((_room_w + _wall_w) * _width_maze) + _wall_w;
	var _height = ((_room_h + _room_h) * _height_maze) + _wall_h;
	
	//Creating the output grid.
	var _grid = jen_grid_create(_width, _height, noone);
	
	//Iterate through the maze to create the walls.
	for (var yy = 0; yy < _height_maze; yy++) {
	for (var xx = 0; xx < _width_maze; xx++)
	{
		var x1 = xx * (_room_w + _wall_w);
		var y1 = yy * (_room_h + _wall_h);
		jen_rectangle(_grid, x1, y1, x1 + ((_room_w + _wall_w) + _wall_w - 1), y1 + ((_room_h + _wall_h) + _wall_h - 1), noone, _value, false);
		jen_rectangle(_grid, x1 + _wall_w, y1 + _wall_h, x1 + ((_room_w + _wall_w) - 1), y1 + ((_room_h + _wall_h) - 1), _value, noone, false);
	}	}
	
	#region Iterate through the maze to create the exits.
	for (var yy = 0; yy < _height_maze; yy++) {
	for (var xx = 0; xx < _width_maze; xx++)
	{
		var x1 = xx * (_room_w + _wall_w);
		var y1 = yy * (_room_h + _wall_h);
		
		#region RIGHT
		if (jen_maze_get(_maze, xx, yy, jen_dir.R))
		{
			jen_rectangle(_grid,
				x1 + _wall_w + _room_w,
				y1 + _wall_h + ((_room_h - _door_h) / 2), //?
				x1 + (_wall_w * 2) + _room_w,
				y1 + _wall_h + ((_room_h + _door_h) / 2) - 1, //?
				_value, noone, false);
		}
		#endregion
		#region UP
		if (jen_maze_get(_maze, xx, yy, jen_dir.U)) //UP
		{
			jen_rectangle(_grid,
			x1 + _wall_w + ((_room_w - _door_w) / 2), //?
			y1,
			x1 + _wall_w + ((_room_w + _door_w) / 2) - 1, //?
			y1 + _wall_h,
			_value, noone, false);
		}
		#endregion
		#region LEFT
		if (jen_maze_get(_maze, xx, yy, jen_dir.L)) //LEFT
		{
			jen_rectangle(_grid,
			x1,
			y1 + _wall_h + ((_room_h - _door_h) / 2), //?
			x1 + _wall_w,
			y1 + _wall_h + ((_room_h + _door_h) / 2) - 1, //?
			_value, noone, false);
		}
		#endregion
		#region DOWN
		if (jen_maze_get(_maze, xx, yy, jen_dir.D)) //DOWN
		{
			jen_rectangle(_grid,
			x1 + _wall_w + ((_room_w - _door_w) / 2), //?
			y1 + _wall_h + _room_h,
			x1 + _wall_w + ((_room_w + _door_w) / 2) - 1, //?
			y1 + (_wall_h * 2) + _room_h,
			_value, noone, false);
		}
		#endregion
	}	}
	#endregion
	
	
	return _grid;
}
#endregion
#region jen_maze_build_list(maze, list, value, room_w, room_h, wall_w, wall_h, door_w, door_h);
/// @func jen_maze_build_list
/// @desc This will generate a new grid based on a maze. It will apply a list of small grids to each room in the maze.
/// @arg  maze
/// @arg  list
/// @arg  value
/// @arg  room_w
/// @arg  room_h
/// @arg  wall_w
/// @arg  wall_h
/// @arg  door_w
/// @arg  door_h
function jen_maze_build_list(_maze, _list, _value, _room_w, _room_h, _wall_w, _wall_h, _door_w, _door_h)
{
	//Create the base maze.
	var _grid = jen_maze_build(_maze, _value, _room_w, _room_h, _wall_w, _wall_h, _door_w, _door_h);
	
	//Getting size values.
	var _width = jen_maze_width(_maze);
	var _height = jen_maze_height(_maze);
	var _size = ds_list_size(_list);
	
	//Iterate through entire maze
	for (var yy = 0; yy < _height; yy ++) {
	for (var xx = 0; xx < _width; xx ++) {
		var x1 = xx * (_room_w + _wall_w);
		var y1 = yy * (_room_h + _wall_h);
		jen_grid_paste(_grid, _list[| irandom(_size - 1)], x1 + _wall_w, y1 + _wall_h, noone);
	} }
	
	return _grid;
}
#endregion
#region jen_maze_build_special(maze, value, room_w, room_h, wall_w, wall_h, door_w, door_h, list_U, list_L, list_I, list_T, list_O, [reflections]);
/// @func jen_maze_build_special
/// @desc Generates a new jen_grid based on a provided maze. Each room will be filled with a random jen_grid from a list, based on the type of exits it has.
/// @arg  maze
/// @arg  value
/// @arg  room_w
/// @arg  room_h
/// @arg  wall_w
/// @arg  wall_h
/// @arg  door_w
/// @arg  door_h
/// @arg  list_U
/// @arg  list_L
/// @arg  list_I
/// @arg  list_T
/// @arg  list_O
/// @arg  [reflections]
function jen_maze_build_special(_maze, _value, _room_w, _room_h, _wall_w, _wall_h, _door_w, _door_h, _list_U, _list_L, _list_I, _list_T, _list_O, _reflections = false)
{
	//Create the base maze.
	var _grid = jen_maze_build(_maze, _value, _room_w, _room_h, _wall_w, _wall_h, _door_w, _door_h);
	var _temp = jen_grid_create(_room_w, _room_h); //Temporary grid for handling rotations and reflections.
	
	//Getting size values.
	var _width = jen_maze_width(_maze);
	var _height = jen_maze_height(_maze);
	
	//Iterate through entire maze
	for (var yy = 0; yy < _height; yy ++) {
	for (var xx = 0; xx < _width; xx ++) {
		var x1 = xx * (_room_w + _wall_w);
		var y1 = yy * (_room_h + _wall_h);
		
		#region Get connection values.
		var R = jen_maze_get(_maze, xx, yy, jen_dir.R);
		var U = jen_maze_get(_maze, xx, yy, jen_dir.U);
		var L = jen_maze_get(_maze, xx, yy, jen_dir.L);
		var D = jen_maze_get(_maze, xx, yy, jen_dir.D);
		
		var _data = R;
		_data += U * 2;
		_data += L * 4;
		_data += D * 8;
		#endregion
	
		#region Getting a random grid of the appropriate type. Applying reflections.
		switch(_data)
		{
			//(U) One Exit
			case 1:	case 2:	case 4:	case 8:
			{
				ds_grid_copy(_temp, _list_U[| irandom(ds_list_size(_list_U) - 1)]);
				if (_reflections)	{	jen_grid_mirror(_temp, irandom(1), false); }
			} break;
			//(L) Two Exits
			case 3: case 6: case 9: case 12:
			{
				ds_grid_copy(_temp, _list_L[| irandom(ds_list_size(_list_L) - 1)]);
			} break;
			//(I) Two Exits
			case 5: case 10:
			{
				ds_grid_copy(_temp, _list_I[| irandom(ds_list_size(_list_I) - 1)]);
				if (_reflections)	{	jen_grid_mirror(_temp, irandom(1), irandom(1));	}
			} break;
			//(T) Three Exits
			case 7: case 11: case 13: case 14:
			{
				ds_grid_copy(_temp, _list_T[| irandom(ds_list_size(_list_T) - 1)]);
				if (_reflections) { jen_grid_mirror(_temp, false, irandom(1)); }
			} break;
			//(O) Four Exits
			case 15:
			{
				ds_grid_copy(_temp, _list_O[| irandom(ds_list_size(_list_O) - 1)]);
				if (_reflections)	{	jen_grid_mirror(_temp, irandom(1), irandom(1));	}
			} break;
		}
		#endregion
		#region Rotating each room to fit.
		if (_data == 15)
		{
			var _rotations = irandom(3);
			if (_rotations != 0) { jen_grid_rotate(_temp, _rotations); }
		}
		else
		{
			if (!R && U) { jen_grid_rotate(_temp, 1); }
			else if (!U && L) { jen_grid_rotate(_temp, 2); }
			else if (!L && D) { jen_grid_rotate(_temp, 3); }
		}
		
		//Applying the final temp grid to the place in the output maze.
		jen_grid_paste(_grid, _temp, x1 + _wall_w, y1 + _wall_h, noone);
		#endregion
	} }
	
	jen_grid_destroy(_temp);
	return _grid;
}
#endregion