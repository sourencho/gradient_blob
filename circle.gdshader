shader_type canvas_item;

uniform vec4 first_color : source_color = vec4(1.0);
uniform vec4 second_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float position : hint_range(-0.5, 0.5) = 0.0;
uniform float size = 0.5;
uniform float angle : hint_range(0.0, 360.0) = 0.0;

void fragment() {
	float pivot = position + 0.5;
	vec2 uv = UV - pivot;
	float rotated = uv.x * cos(radians(angle)) - uv.y * sin(radians(angle)); 
	float pos = smoothstep((1.0 - size) + position, size + 0.0001 + position, rotated + pivot);
	COLOR = mix(first_color, second_color, pos); 
    //COLOR = vec4(1.0, 0.0, 0.0, 1.0);
}

uniform float amplitude : hint_range(0, 100) = 0.1;
uniform float frequency : hint_range(0, 100) = 1.0;
uniform float time_scale : hint_range(0, 100) = 1.0;

void vertex() {
    // Calculate the displacement based on time
    float time = TIME * time_scale;
    float displacement = sin(time *  frequency) * amplitude;
    
    vec2 dirToCenter = normalize(VERTEX - vec2(0.5,0.5)); 

    // Apply the displacement to the vertex position
    VERTEX += displacement*dirToCenter;
}