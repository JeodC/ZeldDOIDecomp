function CRT_Do(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
{
    shader_set(shd_CRT);
    shader_set_uniform_f(global.uni_crt_sizes, arg3[0], arg3[1], arg3[2], arg3[3]);
    shader_set_uniform_f(global.uni_use_radial_distortion, arg4);
    shader_set_uniform_f(global.uni_radial_distortion_amount, clamp(arg5, -2, 2));
    shader_set_uniform_f(global.uni_use_border, arg6);
    shader_set_uniform_f(global.uni_border_corner_size, arg7);
    shader_set_uniform_f(global.uni_border_corner_smoothness, arg8);
    shader_set_uniform_f(global.uni_use_scanlines, arg9);
    shader_set_uniform_f(global.uni_use_RGB_separation, arg10);
    shader_set_uniform_f(global.uni_use_noise, arg11);
    shader_set_uniform_f(global.uni_noise_strength, clamp(arg12, 0, 1));
    shader_set_uniform_f(global.uni_timer, get_timer());
    draw_surface(arg0, arg1, arg2);
    shader_reset();
}

function CRT_Do_Stretch(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14)
{
    shader_set(shd_CRT);
    shader_set_uniform_f(global.uni_crt_sizes, arg5[0], arg5[1], arg5[2], arg5[3]);
    shader_set_uniform_f(global.uni_use_radial_distortion, arg6);
    shader_set_uniform_f(global.uni_radial_distortion_amount, clamp(arg7, -2, 2));
    shader_set_uniform_f(global.uni_use_border, arg8);
    shader_set_uniform_f(global.uni_border_corner_size, arg9);
    shader_set_uniform_f(global.uni_border_corner_smoothness, arg10);
    shader_set_uniform_f(global.uni_use_scanlines, arg11);
    shader_set_uniform_f(global.uni_use_RGB_separation, arg12);
    shader_set_uniform_f(global.uni_use_noise, arg13);
    shader_set_uniform_f(global.uni_noise_strength, clamp(arg14, 0, 1));
    shader_set_uniform_f(global.uni_timer, get_timer());
    draw_surface_stretched(arg0, arg1, arg2, arg3, arg4);
    shader_reset();
}
