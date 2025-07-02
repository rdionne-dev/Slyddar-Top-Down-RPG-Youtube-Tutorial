//==================================================================================
function damage_entity(_tid, _sid, _damage, _time){
    ///@arg {real} tid target_id
    ///@arg {real} sid source_id 
    ///@arg {real} damage how much damage to deal 
    ///@arg {real} time how long to knock back target

    with(_tid) {
        if alarm[HURT] >0 or state == states.DEAD exit;
        hp -= _damage;
        var _dead = is_dead();
        path_end();
        //set knockback
        if _dead var _dis = 5 else var _dis = 3;
        var _dir = point_direction(_sid.x, _sid.y, x, y);
        hsp += lengthdir_x(_dis, _dir);
        vsp += lengthdir_y(_dis, _dir);
        calc_path_delay = _time;
        alert = true;
        knockback_time = _time;
        alarm[HURT] = hurt_time;
        if !_dead state = states.KNOCKBACK;
        return _dead;
    } 
}

//==================================================================================
function is_dead() {
    ///@desc checks if the instance running this is dead

    if state != states.DEAD { 
        if hp <= 0 {
            state = states.DEAD;
            hp = 0;
            image_index = 0;
            //set death sound
            switch(object_index) {
                default:
                    //play sound
                break;
                case obj_player:
                    if instance_exists(my_bow) instance_destroy(my_bow);
                    //player sound
                break;
            }
            return true;
        }
    }
    else return true;
}

//==================================================================================
function check_if_stopped() {
    if abs(hsp) < 0.1 hsp = 0;
    if abs(vsp) < 0.1 vsp = 0;
        
}

//==================================================================================
function show_healthbar() {
    if hp != hp_max and hp > 0 {
        draw_healthbar(x-7, y-16, x+7, y-14, hp/hp_max*100, $003300, $3232FF, $00B200, 0, 1, 0);
    }
    
}

//==================================================================================


//==================================================================================


//==================================================================================


//==================================================================================