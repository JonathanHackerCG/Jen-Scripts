This function will set a value at a position in a JenGrid. It will only change cells that do NOT match the replace value(s). This function can be used as a `setter` parameter for supported functions.

**Syntax**
```js
jen_set(JenGrid, xcell, ycell, replace, new_value);
```

**Arguments**
- ``JenGrid`` The JenGrid to change.
- ``xcell/ycell`` The cell to change.
- ``replace`` Values to replace. Also supports ``all`` or Arrays.
- ``new_value`` Value to set. Also supports Arrays.

**Returns:** True/False if the value at the position was changed.

**Example**
```js
var _w = 20;
var _h = 10;
var _terrain = jen_grid_create(_w, _h, obj_grass);

```

This code will add ``obj_tree`` to the cell corresponding to the mouse cursor, only on cells that do not contain `obj_stone`.