/// @desc MYIMGUI: Draw

//Don't look at this code, I beg you.
var MIDX = room_width	/ 2;
var MIDY = 4 + room_height / 2;
var ENDX = room_width;
var ENDY = room_height;
if (_examples_4x)
{
	draw_set_color(c_white);
	draw_rectangle(1, 10, MIDX - 1, MIDY - 1, true);
	draw_rectangle(MIDX, 10, ENDX - 2, MIDY - 1, true);
	draw_rectangle(1, MIDY, MIDX - 1, ENDY - 2, true);
	draw_rectangle(MIDX, MIDY, ENDX - 2, ENDY - 2, true);
}