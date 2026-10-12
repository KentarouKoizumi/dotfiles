return {
  "sphamba/smear-cursor.nvim",
  opts = {
    cursor_color = "#adf7f5",
    never_draw_over_target = true,
    hide_target_hack = true,

    -- A softer trail at roughly 60 fps, without particle rendering.
    particles_enabled = false,
    time_interval = 17,
    stiffness = 0.65,
    trailing_stiffness = 0.45,
    damping = 0.85,
    distance_stop_animating = 0.3,

    -- Keep typing responsive with a shorter insert-mode trail.
    smear_insert_mode = true,
    stiffness_insert_mode = 0.75,
    trailing_stiffness_insert_mode = 0.65,
    damping_insert_mode = 0.9,
    smear_between_buffers = false,
  },
}
