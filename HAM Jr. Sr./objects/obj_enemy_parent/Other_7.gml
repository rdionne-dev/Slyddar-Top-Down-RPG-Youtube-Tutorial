switch(state) {
    case states.DEAD:
        image_index = image_number -1;
        image_speed = 0;
    break;
}

if (state == states.DEADNUDGE)
{
    state = states.DEAD;
    image_speed = 0;
}