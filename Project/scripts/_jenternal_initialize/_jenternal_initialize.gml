//This contains internal functions referenced inside of other functions in JenScripts.
//These should not be referenced by the user of JenScripts. They do not have documentation.

//Internal JenScripts Macros
#macro JEN_SCRIPTS_VERSION "3.0.0 DEV"
#macro JEN_CELLH global.jen_cellh
#macro JEN_CELLW global.jen_cellw

//Initialization Message
show_debug_message(">>> JenScripts version '" + JEN_SCRIPTS_VERSION + "' initialized!");

//Internal JenScripts Functions (Undocumented)
#region _jenternal_autotile(JenGrid, xx, yy, test, default);
/// @func _jenternal_autotile
/// @desc Converts a value between 0-15 reflecting surrounding tiles to an appropriate tilemap index
/// @arg	{Id.DsGrid}		JenGrid
/// @arg  x1
/// @arg  y1
/// @arg  test
/// @arg  open_edges
function _jenternal_autotile(_grid, _x1, _y1, _test, _default)
{
#region Getting _test values
	var _testU = _jenternal_test(_grid, _x1, _y1 - 1, _test, _default);
	var _testR = _jenternal_test(_grid, _x1 + 1, _y1, _test, _default);
	var _testD = _jenternal_test(_grid, _x1, _y1 + 1, _test, _default);
	var _testL = _jenternal_test(_grid, _x1 - 1, _y1, _test, _default);

	var _testUL = _jenternal_test(_grid, _x1 - 1, _y1 - 1, _test, _default);
	var _testUR = _jenternal_test(_grid, _x1 + 1, _y1 - 1, _test, _default);
	var _testDL = _jenternal_test(_grid, _x1 - 1, _y1 + 1, _test, _default);
	var _testDR = _jenternal_test(_grid, _x1 + 1, _y1 + 1, _test, _default);

	var _tile_default = 17;
	var colB = (1 * _testL) + (2 * _testU) + (4 * _testR) + (8 * _testD);
#endregion

	//_testing if the tile is not part of a 2x2 region. (Return _defaultault tile, for it is invalid).
	if !((_testU && _testUR && _testR) || (_testR && _testDR && _testD) || (_testD && _testDL && _testL) || (_testL && _testUL && _testU))
	{
		return _tile_default;
	}

	//Bitmasking corner tiles (not being present).
	var _test_col = (1 * !_testUL) + (2 * !_testUR) + (4 * !_testDL) + (8 * !_testDR);
	var tile;

	//_testing for correct tile.
	switch (_test_col)
	{
	#region Other _defaultault/Invalid Tiles
		case 6:
			tile = 19; break;
		case 9:
			tile = 18; break;
		case 15:
			tile = _tile_default; break;
	
		case 0: //Fully surrounded tile
			tile = 1;
			switch (colB)
			{
				case 3: tile = 11; break;
				case 6: tile = 10; break;
				case 9: tile = 6; break;
				case 12: tile = 5; break;
			
				case 7: tile = 3; break;
				case 11: tile = 7; break;
				case 13: tile = 13; break;
				case 14: tile = 9; break;
			}
			break;
	#endregion	
	#region Outside Corner Tiles
		case 7:
			tile = 5; break;
		case 11:
			tile = 6; break;
		case 13:
			tile = 10; break;
		case 14:
			tile = 11; break;
	#endregion	
	#region Edge Tiles
		case 3: tile = 13;
			if (_testL ^^ _testR) { tile = (_testL ? 6 : 5); }
			break;
		case 5: tile = 9;
			if (_testU ^^ _testD) { tile = (_testU ? 10 : 5); }
			break;
		case 10: tile = 7;
			if (_testU ^^ _testD) { tile = (_testU ? 11 : 6); }
			break;
		case 12: tile = 3;
			if (_testL ^^ _testR) { tile = (_testL ? 11 : 10); }
			break;
	#endregion
	#region Inside Corner Tiles
		case 1: tile = 14;
	
			if (_testU ^^ _testL) { tile = (_testU ? 9 : 13); }
			else if (!_testU && !_testL && (!_testUL || !_testD)) { tile = 5; }
		
			if ((tile == 9 || tile == 14) && !_testD) { tile = 10; }
			if ((tile == 13 || tile == 14) && !_testR) { tile = 6; }
		
			break;
		case 2: tile = 12;
			if (_testU ^^ _testR) { tile = (_testU ? 7 : 13); }
			else if (!_testU && !_testR && !_testUR) { tile = 6; }
		
			if ((tile == 7 || tile == 12) && !_testD) { tile = 11; }
			if ((tile == 13 || tile == 12) && !_testL) { tile = 5; }
		
			break;
		case 4: tile = 4;
			if (_testL ^^ _testD)
			{ tile = (_testL ? 3 : 9); }
			else if (!_testL && !_testD && !_testDL) { tile = 10; }
		
			if ((tile == 3 || tile == 4) && !_testR) { tile = 11; }
			if ((tile == 9 || tile == 4) && !_testU) { tile = 5; }
		
			break;
		case 8: tile = 2;
			if (_testR ^^ _testD) { tile = (_testR ? 3 : 7); }
			else if (!_testR && !_testD && !_testDR) { tile = 11; }
		
			if ((tile == 3 || tile == 2) && !_testL) { tile = 10; }
			if ((tile == 7 || tile = 2) && !_testU) { tile = 6; }
			break;
	#endregion
	}

#region Correcting for invalid adjacent tiles
	if (tile == 18 || tile == 19)
	{
		if (colB != 15)
		{
			tile = _tile_default;
			if (_testR && _testD && _testDR) { tile = 5; }
			if (_testL && _testD && _testDL) { tile = 6; }
			if (_testR && _testU && _testUR) { tile = 10; }
			if (_testL && _testU && _testUL) { tile = 11; }
		}
	}
#endregion
	
	return tile;
}
#endregion
#region _jenternal_test(JenGrid, x1, y1, test, default);
/// @func _jenternal_test
/// @desc Used internally to do a specialized variation of jen_test.
/// This could probably be replaced but this code-base is over five years old and I ain't touching it.
/// @arg	{Id.DsGrid}		JenGrid
/// @arg  x1
/// @arg  y1
/// @arg  test
/// @arg  default
function _jenternal_test(_grid, _x1, _y1, _test, _default)
{
	if (!jen_grid_inbounds(_grid, _x1, _y1)) { return _default; }
	return jen_test(_grid, _x1, _y1, _test);
}
#endregion

#region _jenternal_convert_array_choose(new_value);
/// @func _jenternal_convert_array_choose
/// @desc	Returns a random value from the array.
/// @arg new_value
/// @returns Value
function _jenternal_convert_array_choose(_new_value)
{
	if (is_array(_new_value))
	{
		//Pick one random value from an array to return.
		var _size = array_length(_new_value);
		var _output = _new_value[irandom(_size - 1)];
		return _output;
	}
	//If it is not an array, return the original value.
	return _new_value;
}
#endregion
#region _jenternal_convert_array_all(replace);
/// @func _jenternal_convert_array_all
/// @desc	Wraps the input in an array if it isn't already.
/// @arg replace
/// @returns Array
function _jenternal_convert_array_all(_replace)
{
	if (!is_array(_replace)) { return [_replace]; }
	return _replace;
}
#endregion

#region _jenternal_array_has_value(array, value);
/// @func _jenternal_array_has_value(array, value):
/// @arg {Array} array
/// @arg {Any} value
function _jenternal_array_has_value(_array, _value)
{
	var _size = array_length(_array);
	for (var i = 0; i < _size; i++)
	{
		if (_array[i] == _value) { return true; }
	}
	return false;
}
#endregion

#region _jenternal_percent(chance);
function _jenternal_percent(_chance)
{
	return (_chance >= 100 || random(100) < _chance);
}
#endregion