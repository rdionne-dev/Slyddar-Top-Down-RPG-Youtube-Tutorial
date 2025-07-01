#macro tilesize    16

var _w = ceil(room_width / tilesize);
var _h = ceil(room_height / tilesize);

global.mp_grid = mp_grid_create(0, 0, _w, _h, tilesize, tilesize);

mp_grid_add_instances(global.mp_grid, obj_solid, false);
