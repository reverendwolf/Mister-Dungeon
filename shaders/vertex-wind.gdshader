shader_type spatial;
render_mode depth_prepass_alpha, cull_disabled, world_vertex_coords;

uniform sampler2D texture_albedo : source_color, filter_nearest;

uniform float sway_speed = 1.0;
uniform float sway_strength = 0.05;
uniform float sway_phase_len = 8.0;

void vertex()
{
	float strength = COLOR.r * sway_strength;
	VERTEX.x += sin(VERTEX.x * sway_phase_len * 1.123 + TIME * sway_speed) * strength;
	VERTEX.y += sin(VERTEX.y * sway_phase_len + TIME * sway_speed * 1.124) * strength;
	VERTEX.z += sin(VERTEX.z * sway_phase_len * 0.912 + TIME * sway_speed * 1.312) * strength;
}

void fragment() {
	vec4 albedo_tex = texture(texture_albedo, UV);
	ALBEDO = albedo_tex.rgb;
	ALPHA = albedo_tex.a;
	ALPHA_SCISSOR_THRESHOLD= 0.6;
	METALLIC = 0.0;
	ROUGHNESS = 1.0;
}
