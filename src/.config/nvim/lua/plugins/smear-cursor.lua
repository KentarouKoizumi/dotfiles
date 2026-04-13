return {
  "sphamba/smear-cursor.nvim",
  opts = {
    never_draw_over_target = true, -- if you want to actually see under the cursor
    hide_target_hack = true,       -- same

    stiffness = 0.6,
    trailing_stiffness = 0.2,
    damping = 0.5,
    trailing_exponent = 5,
    gradient_exponent = 0,

    cursor_color = "#adf7f5",
    gamma = 2,

    particles_enabled = true,
    particle_spread = 1,
    particle_max_num = 100,
    particles_per_second = 2,
    particles_per_length = 20,
    particle_max_lifetime = 500,
    particle_lifetime_distribution_exponent = 1,
    particle_max_initial_velocity = 100,
    particle_velocity_from_cursor = 0,
    particle_random_velocity = 100,
    particle_damping = 0.30,
    particle_gravity = 10,
    particles_over_text = false,

    min_distance_emit_particles = 0,
  }
}
