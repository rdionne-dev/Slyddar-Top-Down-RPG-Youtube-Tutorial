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
        // --- THIS IS THE UPDATED LOGIC ---
        
        // 1. Identify what, if anything, is nudging us.
        var _nudger = noone;
        var _colliding_enemy = instance_place(x, y, obj_enemy_parent);

        // First, check for a live enemy collision.
        // The check 'state < states.DEAD' works because IDLE, MOVE, etc. have lower enum values.
        if (_colliding_enemy != noone && _colliding_enemy.state < states.DEAD)
        {
            _nudger = _colliding_enemy;
        }
        // If not a live enemy, check for the player.
        else if (instance_exists(obj_player) && place_meeting(x, y, obj_player))
        {
            _nudger = obj_player;
        }

        // 2. If we were nudged by a valid object...
        if (_nudger != noone)
        {
            // ALWAYS apply the physical nudge.
            var _nudge_dir = point_direction(_nudger.x, _nudger.y, x, y);
            hsp += lengthdir_x(5, _nudge_dir);
            vsp += lengthdir_y(5, _nudge_dir);

            // OPTIONALLY, trigger the special animation state if the nudge sprite exists.
            if (spr_deadnudge != -1)
            {
                state = states.DEADNUDGE;
                image_index = 0;
                image_speed = 1.5;
            }
        }

        // 3. Process physics and animation for this frame.
        calc_entity_movement();
        hsp *= 0.2; // Apply high friction
        vsp *= 0.2;

        enemy_anim();
    break;

    case states.DEADNUDGE:
        // This state's only job is to play the animation while moving.
        // The physics are identical to a nudged body in the DEAD state.
        calc_entity_movement();
        hsp *= 0.2; // Apply high friction
        vsp *= 0.2;

        enemy_anim();
    break;
}