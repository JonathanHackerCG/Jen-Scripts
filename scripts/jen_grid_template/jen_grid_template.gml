/// @function JenTemplate()
JenTemplate = function() constructor
{
	layers = ds_list_create();
	rules = ds_list_create();
	
	/// @function destroy()
	/// @description Clears memory for the JenTemplate.
	function destroy()
	{
		var size = ds_list_size(layers);
		for (var i = 0; i < size; i++)
		{
			layers[| i].destroy();
		}
	}
	
	/// @function generate()
	/// @description Returns a new JenGrid based on the JenTemplate.
	function generate()
	{
		
	}
}