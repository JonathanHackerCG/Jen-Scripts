/// @desc MYIMGUI: Render
ImGui.__Render();
for (var i = _visible_layer_max; i >= 1; i--) {
	var xx = 4;
	var yy = 24 + (12 * (i - 1));
	draw_rectangle(xx, yy, xx + 12, yy + 8, _visible_layer <= (_visible_layer_max - i));
}