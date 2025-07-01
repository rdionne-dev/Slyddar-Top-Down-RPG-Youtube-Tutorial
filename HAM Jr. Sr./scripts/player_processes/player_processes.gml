//==================================================================================
//============|| WARNING - IF YOU LOOK AT THIS KOOL KODE BELOW ||===================
//================|| YOUR SOCKS MAY BLAST OFF OF YOUR FEET ||=======================
//========================|| READ AT YOUR OWN RISK ||===============================
//==================================================================================
function reset_variables(){
    left   = 0;
    right  = 0;
    up     = 0;
    down   = 0;
    hmove  = 0;
    vmove  = 0;
}

//==================================================================================
function get_input() {
    if keyboard_check(ord("A")) left     = 1;
    if keyboard_check(ord("D")) right    = 1;
    if keyboard_check(ord("W")) up       = 1;
    if keyboard_check(ord("S")) down     = 1;
}

//==================================================================================
function calc_movement() {
    hmove = right - left;
    vmove = down - up;
    
    var _facing = (aim_dir < 90 or aim_dir > 270);
    if _facing == 0 _facing = -1;
    facing = _facing;
    
    if hmove != 0 or vmove != 0 {
        var _dir = point_direction(0, 0, hmove, vmove);
       
        hmove = lengthdir_x(walk_speed, _dir);
        vmove = lengthdir_y(walk_speed, _dir);
        
        x += hmove;
        y += vmove;
    }
    
    aim_dir = point_direction(x, y, mouse_x, mouse_y);
    my_bow.image_angle = aim_dir;
}

//==================================================================================
function collision() {
    var _tx = x;
    var _ty = y;
    
    x = xprevious;
    y = yprevious;
    
    var _disx = abs(_tx - x);
    var _disy = abs(_ty - y);
    
    repeat (_disx) {
        if !place_meeting(x + sign(_tx - x), y, obj_solid) x += sign (_tx - x);
    }
        repeat (_disy) {
        if !place_meeting(x, y + sign(_ty - y), obj_solid) y += sign (_ty - y);
    }
}

//==================================================================================
function anim() {
    if hmove != 0 or vmove != 0 {
    	sprite_index = spr_player_walk;
    }
    else {
        sprite_index = spr_player_idle;
    }
}

//==================================================================================
function check_fire(){
    if mouse_check_button(mb_left) {
        if can_fire {
            can_fire = false;
            alarm[0] = fire_rate;
            
            var _dir = point_direction(x, y, mouse_x, mouse_y);
            bow_dis = 5;
            
            var _inst = instance_create_layer(x,y, "Arrow", obj_arrow);
            with (_inst) {
            	speed = other.arrow_speed;
                direction = _dir;
                image_angle = _dir;
                owner_id = other;
                
            }
            
        } 
        	
    }
}

//==================================================================================


