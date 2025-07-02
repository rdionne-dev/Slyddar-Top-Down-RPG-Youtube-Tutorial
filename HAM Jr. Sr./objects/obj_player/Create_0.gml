event_inherited();

//player
walk_speed = 1.5;
hp_max = 10;
hp = hp_max;

//bow
aim_dir = 0; 
bow_dis = 11; 
fire_rate = 30;
can_attack = true;
arrow_speed = 5;   

my_bow = instance_create_layer(x, y, "Instances", obj_bow);

//cursor
cursor_sprite = spr_cursor;
window_set_cursor(cr_none);
ready_to_restart = false;