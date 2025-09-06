shader_type canvas_item;

uniform float darken_intensity = 1.0;
uniform sampler2D noise_texture : repeat_enable;
uniform vec2 moveDir = vec2(1.0,0.0);
uniform float speed = 1.0;
uniform float effect_intensity : hint_range(0.0, 1.0, 0.1) = 1.0;
uniform bool enabled = true;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 sample_speed = moveDir * speed;
	vec2 noise_uv = UV;
	noise_uv = noise_uv + moveDir * speed * TIME;
	COLOR = texture(TEXTURE, UV); // Read from texture again.
	vec4 noise_color = texture(noise_texture,noise_uv);

	if (enabled) {
		COLOR.rgb = COLOR.rgb * noise_color.r * effect_intensity;
		COLOR.xyz = COLOR.xyz * darken_intensity * effect_intensity;
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
