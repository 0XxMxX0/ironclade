shader_type canvas_item;

uniform float scroll_speed : hint_range(0, 2) = 0.08;
uniform float angle_degrees : hint_range(0, 360) = 45.0;
uniform float repeat_x : hint_range(1, 20) = 20;
uniform float repeat_y : hint_range(1, 20) = 12;
uniform float row_offset : hint_range(0, 1) = 1;
uniform sampler2D texture_to_scroll;
uniform vec2 texture_size; // Pass the texture size as a uniform
uniform float tile_size_x : hint_range(1, 50) = 3.0; // Control the tile size along the X-axis
uniform float tile_size_y : hint_range(1, 50) = 3.0; // Control the tile size along the Y-axis
uniform float bubble_radius : hint_range(0.01, 1.0) = 0.3; // Control the radius of the bubbles

void fragment() {
    float angle_rad = radians(angle_degrees);

    vec2 direction = vec2(cos(angle_rad), sin(angle_rad));

    vec2 offset_uv = UV - (TIME * scroll_speed * direction);

    float offset = fract(floor(offset_uv.y * repeat_y) * 0.5) > 0.0 ? (row_offset * 0.324) : 0.0;

    offset_uv.x += offset;

    vec2 scaled_uv = vec2(fract(offset_uv.x * repeat_x), fract(offset_uv.y * repeat_y));

    vec2 texelSize = vec2(1.0) / texture_size;
    vec2 snappedUV = round(scaled_uv / texelSize) * texelSize;

    // Adjust the UV coordinates based on the tile size
    vec2 tile_uv = scaled_uv * vec2(tile_size_x, tile_size_y);

    // Calculate the position of the center of each tile
    vec2 tile_center = vec2(0.5 / tile_size_x, 0.5 / tile_size_y);

    // Calculate distance from the current UV to the center of the tile
    float dist = distance(fract(tile_uv), tile_center);

    // Define the colors
    vec4 bubble_color = vec4(255.0 / 255.0, 195.0 / 255.0, 103.0 / 255.0, 1.0); // #FFC367
    vec4 background_color = vec4(1.0, 1.0, 1.0, 1.0); // White background

    // Use the distance to determine whether the fragment is inside the bubble or in the background
    if (dist < bubble_radius / tile_size_x) {
        COLOR = bubble_color; // Inside the bubble
    } else {
        COLOR = background_color; // Outside the bubble
    }
}
