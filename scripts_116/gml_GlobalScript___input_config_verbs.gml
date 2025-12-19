function __input_config_verbs()
{
    return 
    {
        keyboard: 
        {
            up: input_binding_key(38),
            down: input_binding_key(40),
            left: input_binding_key(37),
            right: input_binding_key(39),
            sword: input_binding_key(17),
            action: input_binding_key(18),
            item: input_binding_key(90),
            map: input_binding_key(77),
            strafe: input_binding_key(16),
            inventory: input_binding_key(13),
            menu_access: input_binding_key(27),
            menu_input: [input_binding_key(13), input_binding_key(17)],
            hud: input_binding_key(112)
        },
        gamepad: 
        {
            up: [input_binding_gamepad_axis(32786, true), input_binding_gamepad_button(32781)],
            down: [input_binding_gamepad_axis(32786, false), input_binding_gamepad_button(32782)],
            left: [input_binding_gamepad_axis(32785, true), input_binding_gamepad_button(32783)],
            right: [input_binding_gamepad_axis(32785, false), input_binding_gamepad_button(32784)],
            sword: input_binding_gamepad_button(32769),
            action: input_binding_gamepad_button(32770),
            item: input_binding_gamepad_button(32771),
            map: input_binding_gamepad_button(32772),
            strafe: input_binding_gamepad_button(32776),
            inventory: input_binding_gamepad_button(32778),
            menu_access: input_binding_gamepad_button(32777),
            menu_input: [input_binding_gamepad_button(32778), input_binding_gamepad_button(32769)],
            hud: input_binding_gamepad_button(32780)
        }
    };
}
