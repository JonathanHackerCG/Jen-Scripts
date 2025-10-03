// VERSION CONFIG: Uncomment the code for the version you are using.
// 2023.8+ --------------------------------------------------------------------------------------------------

/*
#macro __terra_object_exists object_exists
#macro __terra_ds_exists ds_exists
*/

// ----------------------------------------------------------------------------------------------------------
// <2023.8 (LTS) --------------------------------------------------------------------------------------------

//TODO: Cleanup, not sure if LTS will be supported at all. Maybe for v3.1.0.
#region __terra_object_exists(index);
/// @func __terra_object_exists(index):
/// @desc Used as a robust object_exists for <2023.8.
/// @arg	{Real} index
function __terra_object_exists(_index)
{
	return is_numeric(_index) && object_exists(_index);
}
#endregion
#region __terra_ds_exists(index);
/// @func __terra_ds_exists(index):
/// @desc Used as a robust ds_exists for <2023.8.
/// @arg	{Real} index
/// @arg	{Real} type
function __terra_ds_exists(_index, _type)
{
	return is_real(_index) && ds_exists(_index, _type);
}
#endregion


// ----------------------------------------------------------------------------------------------------------