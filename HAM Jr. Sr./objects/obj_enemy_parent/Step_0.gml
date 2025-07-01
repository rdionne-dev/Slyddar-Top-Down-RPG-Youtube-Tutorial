enemy_antibunch();

switch(state) {
    case states.IDLE: 
        calc_entity_movement();
        check_for_player();
        if path_index != -1 state = states.MOVE;
        enemy_anim();
    break;

    case states.MOVE:
        calc_entity_movement();
        check_for_player();
        check_facing();
        if path_index == -1 state = states.ATTACK;
        enemy_anim();
    break;
    
    case states.ATTACK:
        calc_entity_movement();
        enemy_anim();
        
        var _dis = distance_to_object(obj_player);

        if (_dis > attack_dis) 
        {
            state = states.MOVE;
        }

        else if (_dis < attack_dis) 
        {
            var _dir_away = point_direction(obj_player.x, obj_player.y, x, y);

            var _move_x = lengthdir_x(move_speed, _dir_away);
            var _move_y = lengthdir_y(move_speed, _dir_away);
            
            if (!place_meeting(x + _move_x, y, obj_solid))
            {
                x += _move_x;
            }
            if (!place_meeting(x, y + _move_y, obj_solid))
            {
                y += _move_y;
            }
        }
    break;
    
    case states.KNOCKBACK:
        calc_knockback_movement();
        enemy_anim();
    break;
    
    case states.DEAD:

        if (place_meeting(x, y, obj_player))
        {
            var _nudge_dir = point_direction(obj_player.x, obj_player.y, x, y);
            hsp += lengthdir_x(0.5, _nudge_dir);
            vsp += lengthdir_y(0.5, _nudge_dir);
        }
        
        calc_entity_movement();
        hsp *= 0.2;
        vsp *= 0.2;
        enemy_anim();
    break;
}