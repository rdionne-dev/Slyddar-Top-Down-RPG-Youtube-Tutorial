switch(state) {
    default:
        reset_variables();

        get_input();

        calc_movement();

        check_fire();

        anim();
    break;
    
    case states.KNOCKBACK:
        reset_variables();

        calc_movement();
    
        if knockback_time-- <= 0 state = states.IDLE;

        anim();
    break;
    
    case states.DEAD:
        reset_variables();

        calc_movement();

        if ready_to_restart and mouse_check_button_pressed(mb_left) game_restart ();

        anim();
    break;
}

depth = (-bbox_bottom -5);