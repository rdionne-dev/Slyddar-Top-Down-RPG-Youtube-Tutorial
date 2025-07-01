//==================================================================================
function check_facing() {
    if knockback_time <= 0 {
        var _facing = sign(x - xprev);
        if _facing != 0 facing = _facing;
    }
}

//==================================================================================
function enemy_anim(){
    
    switch(state) {
        case states.IDLE: 
            sprite_index = spr_idle;
            show_hurt();
        break;
       
        case states.MOVE:
            sprite_index = spr_walk;
            show_hurt();
        break;
        
        case states.ATTACK:
            sprite_index = spr_attack;
        break;
        
        case states.KNOCKBACK:
            sprite_index = spr_hurt;
            show_hurt();
        break;
        
        case states.DEAD:
            sprite_index = spr_dead;
        break;
    }
    depth = -bbox_bottom;
    
    xprev = x;
    yprev = y;
    
}

//==================================================================================
function check_for_player(){
    
    var _dis = distance_to_object(obj_player);
    
    // Condition to chase the player
    if ((_dis <= alert_dis) or alert) and _dis > attack_dis {
    
        alert = true;
        
        if calc_path_timer-- <= 0 {
            calc_path_timer = calc_path_delay;
            
            var _type = 0;
            if x != xprev or y != yprev {
                _type = 1;
            }
            
            // We now check the 'pushed_apart' instance variable.
            // Pathfinding will be paused if the variable was set to 'true'.
            if (!pushed_apart)    
            {
                var _found_player = mp_grid_path(global.mp_grid, path, x, y, obj_player.x, obj_player.y, _type);
            
                if _found_player {
                    path_start(path, move_speed, path_action_stop, false);
                }
            }
        }
    }
    // Condition to attack the player
    else if (_dis <= attack_dis) {
        path_end();
        state = states.ATTACK; // This is the added line to fix the attack state!
    }
}

//==================================================================================
function enemy_antibunch(){    
    
    // This now sets the INSTANCE variable, not a temporary one.
    pushed_apart = false;
    var_colliding = instance_place(x, y, obj_enemy);
    
    if (var_colliding != noone)
    {
        var_dir = point_direction(var_colliding.x, var_colliding.y, x, y);
        var_push_x = x + lengthdir_x(1, var_dir);
        var_push_y = y + lengthdir_y(1, var_dir);
    
        if (!place_meeting(var_push_x, var_push_y, obj_solid))
        {
            x = var_push_x;
            y = var_push_y;
            
            // THE KEY CHANGE: Only set the flag if we are outside of attack range.
            if (distance_to_object(obj_player) > attack_dis)
            {
                pushed_apart = true;
            }
        }
    }
    
}

//==================================================================================
function calc_entity_movement() {
    x += hsp;
    y += vsp;
    
    hsp *= global.drag;
    vsp *= global.drag;
    
    check_if_stopped();
    
}

//==================================================================================
function calc_knockback_movement() {
    x += hsp;
    y += vsp;
    
    hsp *= 0.91;
    vsp *= 0.91;
    
    check_if_stopped();
    
    if knockback_time <= 0 state = states.IDLE;
    
}

//==================================================================================
function show_hurt() {
    if knockback_time-- > 0 sprite_index = spr_hurt
}

//==================================================================================