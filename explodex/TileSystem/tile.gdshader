shader_type canvas_item;

uniform vec4 sprite_color : source_color = vec4(1.0, 1.0, 1.0, 1.0); // Default to white
uniform float effect_enabled : hint_range(0.0, 1.0) = 1.0;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    COLOR = tex_color * sprite_color;
}