//Maze generation, including creation, modification, and instantiation.

enum JEN_DIR
{
	NONE = 0,
	R = 1,
	U = 2,
	L = 4,
	D = 8,
	ANY = 15
}

//Initialization
#region jen_maze_create(width, height);
/// @func jen_maze_create(width, height):
/// @desc Creates a new blank JenMaze. Mostly for internal use.
/// @arg  {Real}	width
/// @arg  {Real}	height
function jen_maze_create(_w, _h)
{
	var _maze = ds_grid_create(_w, _h);
	ds_grid_clear(_maze, 0);
	return _maze;
}
#endregion
#region jen_maze_create_prim(width, height);
/// @func jen_maze_create_prim(width, height):
/// @desc Creates a new maze using Prim's algorithm.
/// https://en.wikipedia.org/wiki/Prim%27s_algorithm
/// @arg  {real}	width
/// @arg  {real}	height
function jen_maze_create_prim(_w, _h)
{
	//Create maze and lists.
	var _maze = jen_maze_create(_w, _h);
	var _positions = ds_list_create();
	static _options = ds_list_create();

	//Initialize a random starting position.
	var xx = irandom(_w - 1);
	var yy = irandom(_h - 1);
	ds_list_add(_positions, { x1 : xx, y1 : yy});

	while (ds_list_size(_positions) >= 1)
	{
		//Choose a new random position from among the list
		var _index = irandom(ds_list_size(_positions) - 1);
		var _pos = _positions[| _index];
		xx = _pos.x1; yy = _pos.y1;
	
		//If all surrounding positions are filled.
		ds_list_clear(_options);
		if (jen_maze_get_dir(_maze, xx + 1, yy, JEN_DIR.ANY) == false) { ds_list_add(_options, JEN_DIR.R); }
		if (jen_maze_get_dir(_maze, xx, yy - 1, JEN_DIR.ANY) == false) { ds_list_add(_options, JEN_DIR.U); }
		if (jen_maze_get_dir(_maze, xx - 1, yy, JEN_DIR.ANY) == false) { ds_list_add(_options, JEN_DIR.L); }
		if (jen_maze_get_dir(_maze, xx, yy + 1, JEN_DIR.ANY) == false) { ds_list_add(_options, JEN_DIR.D); }
		if (ds_list_size(_options) == 0)
		{
			ds_list_delete(_positions, _index);
		}
		else //There is an open position.
		{
			var _dir = _options[| irandom(ds_list_size(_options) - 1)];
			jen_maze_set_dir(_maze, xx, yy, _dir, true);
			switch (_dir) {
				case JEN_DIR.R: { ds_list_add(_positions, { x1 : xx + 1, y1 : yy }); } break;
				case JEN_DIR.U: { ds_list_add(_positions, { x1 : xx, y1 : yy - 1 }); } break;
				case JEN_DIR.L: { ds_list_add(_positions, { x1 : xx - 1, y1 : yy }); } break;
				case JEN_DIR.D: { ds_list_add(_positions, { x1 : xx, y1 : yy + 1 }); } break;
			}
		}
	}

	//Cleanup and return.
	ds_list_destroy(_positions);
	return _maze;
}
#endregion
#region jen_maze_create_backtrack(width, height);
/// @func jen_maze_create_backtrack
/// @desc Creates a new maze using Recursive Backtrack algorithm.
/// @arg  width
/// @arg  height
function jen_maze_create_backtrack(_w, _h)
{
	//Create maze and lists.
	var _maze = jen_maze_create(_w, _h);
	var _positions = ds_list_create();
	static _options = ds_list_create();

	//Initialize a random starting position.
	var xx = irandom(_w - 1);
	var yy = irandom(_h - 1);
	do
	{
		//Build a list of all adjacent rooms that have not been connected.
		ds_list_clear(_options);
		if (jen_maze_get_dir(_maze, xx + 1, yy, JEN_DIR.ANY) == false) { ds_list_add(_options, JEN_DIR.R); }
		if (jen_maze_get_dir(_maze, xx, yy - 1, JEN_DIR.ANY) == false) { ds_list_add(_options, JEN_DIR.U); }
		if (jen_maze_get_dir(_maze, xx - 1, yy, JEN_DIR.ANY) == false) { ds_list_add(_options, JEN_DIR.L); }
		if (jen_maze_get_dir(_maze, xx, yy + 1, JEN_DIR.ANY) == false) { ds_list_add(_options, JEN_DIR.D); }
		if (ds_list_size(_options) == 0) //There are no options.
		{
			//Delete the end of the backtrack chain.
			var _size = ds_list_size(_positions);
			var _pos = _positions[| _size - 1];
			xx = _pos.x1; yy = _pos.y1;
			ds_list_delete(_positions, _size - 1);
		}
		else
		{
			//Add the next cell to the list.
			ds_list_add(_positions, { x1 : xx, y1 : yy });
		
			//Connect this cell with a random adjacent cell.
			var _dir = _options[| irandom(ds_list_size(_options) - 1)];
			jen_maze_set_dir(_maze, xx, yy, _dir, true);
			switch (_dir) {
				case JEN_DIR.R: { xx ++; } break;
				case JEN_DIR.U: { yy --; } break;
				case JEN_DIR.L: { xx --; } break;
				case JEN_DIR.D: { yy ++; } break;
			}
		}
	} until (ds_list_size(_positions) == 0);

	//Cleanup and return.
	ds_list_destroy(_positions);
	return _maze;
}
#endregion
#region jen_maze_destroy(JenMaze);
/// @func jen_maze_destroy(JenMaze):
/// @desc Destroy a JenMaze, clearing it from memory.
///				Returns true if the JenMaze was successfully destroyed.
/// @arg  {Id.DsGrid}	JenMaze
/// @returns {Bool}
function jen_maze_destroy(_maze)
{
	if (jen_maze_exists(_maze))
	{
		ds_grid_destroy(_maze);
		return true;
	}
	return false;
}
#endregion
#region NEW jen_maze_exists(JenMaze);
/// @func jen_maze_exists(JenMaze):
/// @desc Returns true if a JenMaze exists.
///				NOTE: Currently cannot distinguish between a JenMaze and a DS Grid.
/// @arg	{Id.DsGrid}	JenMaze
/// @returns {Bool}
function jen_maze_exists(_grid)
{
	return _jenternal_ds_exists(_grid, ds_type_grid);
}
#endregion

//Getters/Setters
#region jen_maze_get_dir(JenMaze, xcell, ycell, jen_dir);
/// @func jen_maze_get_dir(JenMaze, xcell, ycell, jen_dir):
/// @desc Returns true/false if a particular direction is connected.
///				Also supports JEN_DIR.ANY to check for any connection.
///				Returns undefined if it is out of bounds.
/// @arg  {Id.DsGrid}			JenMaze
/// @arg  {Real}					xcell
/// @arg  {Real}					ycell
/// @arg  {Enum.JEN_DIR}	jen_dir
function jen_maze_get_dir(_maze, _x1, _y1, _dir)
{
	if (!jen_grid_inbounds(_maze, _x1, _y1)) { return undefined; }
	return (_maze[# _x1, _y1] & _dir) != 0;
}
#endregion
#region jen_maze_set_dir(JenMaze, xcell, ycell, direction, is_connected, [one_way]);
/// @func jen_maze_set_dir(JenMaze, xcell, ycell, direction, is_connected, [one_way]):
/// @desc Sets a direction from a cell in the JenMaze to be connected (true/false).
/// @arg  {Id.DsGrid}			JenMaze
/// @arg  {Real}					xcell
/// @arg  {Real}					ycell
/// @arg  {Enum.JEN_DIR}	direction
/// @arg  {Bool}					is_connected
/// @arg	{Bool}					[one_way]			Default: false
/// @returns {Bool}
function jen_maze_set_dir(_maze, _x1, _y1, _dir, _value, _oneway = false)
{
	if (!jen_grid_inbounds(_maze, _x1, _y1)) { exit; }
	if (_value)
	{
		_maze[# _x1, _y1] = _maze[# _x1, _y1] | _dir;
	}
	else
	{
		_maze[# _x1, _y1] = _maze[# _x1, _y1] & ~_dir;
	}
	
	if (!_oneway)
	{
		//TODO: Update to allow bitwise | operation to change multiple directions at once.
		switch (_dir)
		{
			case JEN_DIR.R: { jen_maze_set_dir(_maze, _x1 + 1, _y1, JEN_DIR.L, _value, true); } break;
			case JEN_DIR.U: { jen_maze_set_dir(_maze, _x1, _y1 - 1, JEN_DIR.D, _value, true); } break;
			case JEN_DIR.L: { jen_maze_set_dir(_maze, _x1 - 1, _y1, JEN_DIR.R, _value, true); } break;
			case JEN_DIR.D: { jen_maze_set_dir(_maze, _x1, _y1 + 1, JEN_DIR.U, _value, true); } break;
		}
	}
}
#endregion
#region jen_maze_width(JenMaze);
/// @func jen_maze_width(JenMaze):
/// @desc Returns the width of a JenMaze.
/// @arg  {Id.DsGrid}	JenMaze
function jen_maze_width(_maze)
{
	return ds_grid_width(_maze);
}
#endregion
#region jen_maze_height(JenMaze);
/// @func jen_maze_height(JenMaze):
/// @desc Returns the height of a JenMaze.
/// @arg  {Id.DsGrid}	JenMaze
function jen_maze_height(_maze)
{
	return ds_grid_height(_maze);
}
#endregion

//Maze creation/modification.
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
			jen_maze_set_dir(_maze, _list[| i], 0, JEN_DIR.U, true);
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
			jen_maze_set_dir(_maze, _width - 1, _list[| i], JEN_DIR.R, true);
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
			jen_maze_set_dir(_maze, _list[| i], _height - 1, JEN_DIR.D, true);
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
			jen_maze_set_dir(_maze, 0, _list[| i], JEN_DIR.L, true);
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
		if (jen_maze_get_dir(_maze, xx, yy, JEN_DIR.R))
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
		if (jen_maze_get_dir(_maze, xx, yy, JEN_DIR.U)) //UP
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
		if (jen_maze_get_dir(_maze, xx, yy, JEN_DIR.L)) //LEFT
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
		if (jen_maze_get_dir(_maze, xx, yy, JEN_DIR.D)) //DOWN
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
		var R = jen_maze_get_dir(_maze, xx, yy, JEN_DIR.R);
		var U = jen_maze_get_dir(_maze, xx, yy, JEN_DIR.U);
		var L = jen_maze_get_dir(_maze, xx, yy, JEN_DIR.L);
		var D = jen_maze_get_dir(_maze, xx, yy, JEN_DIR.D);
		
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