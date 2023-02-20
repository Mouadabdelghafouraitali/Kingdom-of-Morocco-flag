#define PI 3.14159265 
#define hexagon(uv, sides) shape(uv, sides)
//pentagram from : https://www.shadertoy.com/view/MlBBWt

mat2 rotate(float angle) {
	float c = cos(angle), s = sin(angle);
	return mat2(c, s, -s, c);
}

float shape(vec2 uv, float sides) {
	float a = atan(uv.x, uv.y) + PI;
	float r = 2. * PI / sides;
	return cos(floor(.5 + a / r) * r - a) * length(uv);
}

float offset(float distance, float radius, float scale) {
	return abs(distance - radius) * scale * 2.0;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
	vec3 backgroundColor = vec3(0.761, 0.133, 0.161); 
	vec3 starColor = vec3(0.008, 0.373, 0.188);
	vec2 uv = (fragCoord - .5 * iResolution.xy) / iResolution.y;
	uv *= rotate(sin(0.68));
	float pen1 = hexagon(uv * vec2(1, -1), 5.);
	float pen2 = hexagon(uv, 5.);
	float d = offset((pen1 - pen2 * .605) * 4.0, .28, .8);
	d = min(d, offset(pen2, .110, 2.5));
	fragColor = vec4(mix(starColor, backgroundColor, smoothstep(.1, .11, d)), 1.0);
}
