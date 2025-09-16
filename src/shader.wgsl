// // Vertex shader
// 
// struct VertexOutput {
//     @builtin(position) clip_position: vec4<f32>,
// };
// 
// @vertex
// fn vs_main(
//     @builtin(vertex_index) in_vertex_index: u32, // what the hell is this???? still don't understand. too much for my monke brain
// ) -> VertexOutput {
//     var out: VertexOutput;
//     let x = f32(1 - i32(in_vertex_index)) * 0.5; 
//     // for index = 0 f32(1-0) * 0.5 =  0.5 (f32)
//     // for index = 1 f32(1-1) * 0.5 =  0   (f32)
//     // for index = 2 f32(1-2) * 0.5 = -0.5 (f32)
//     // for index = 3 f32(1-3) * 0.5 = -1.0 (f32)
//     // for index = 4 f32(1-4) * 0.5 = -1.5 (f32) // guess this one is out of screen - that's why it's not showing
// 
// 
// 
//     let y = f32(i32(in_vertex_index & 1u) * 2 - 1) * 0.5;
//     // for index = 0 f32((0 & 1u) * 2 - 1) * 0.5 =  -0.5 (f32)
//     // for index = 1 f32((1 & 1u) * 2 - 1) * 0.5 =  0.5 (f32)
//     // for index = 2 f32((1 & 1u) * 2 - 1) * 0.5 =  -0.5 (f32)
// 
//     out.clip_position = vec4<f32>(x, y, 0.0, 1.0);
//     return out;
// }
// 
// @fragment
// fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
//     // return vec4<f32>(0.3, 0.2, 0.1, 1.0);
//     return vec4<f32>(in.clip_position.x, in.clip_position.y, 0., 1.0);
//     //this shit is fancy magic tho
// 
//     // i still don't get why is there VertexOutput as an argument
//     // like it colors the whole area of the triangle
//     // so it seems the fragment function runs for all the pixels
//     // contained inside the vertices of the triangle
// 
//     // pretty funky if you ask me
//     // okay so it gets run for every created primitive
//     // still don't get why VertexOutput is an argument tho
//     // like it seems it would run per every vertex because VertexOutput supposedly stores vertex position
// 
//     //okay i guess location(0) is kinda related to the screen - surface
//     //like each pixel gets a location address to which this function writes data (returns) and the surface texture can read from!
//     // that's JUST my lucky guess tho
// }

struct VertexOutput {
    @builtin(position) clip_position: vec4<f32>,
    @location(0) color: vec3<f32>,   // <-- custom varying
};

@vertex
fn vs_main(@builtin(vertex_index) in_vertex_index: u32) -> VertexOutput {
    var out: VertexOutput;

    let positions = array<vec2<f32>, 3>(
        vec2<f32>(0.0, 0.5),   // top
        vec2<f32>(-0.5, -0.5), // bottom left
        vec2<f32>(0.5, -0.5),  // bottom right
    );

    let colors = array<vec3<f32>, 3>(
        vec3<f32>(1.0, 0.0, 0.0), // red
        vec3<f32>(0.0, 1.0, 0.0), // green
        vec3<f32>(0.0, 0.0, 1.0), // blue
    );

    out.clip_position = vec4<f32>(positions[in_vertex_index], 0.0, 1.0);
    out.color = colors[in_vertex_index]; // pass a color per-vertex
    return out;
}

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    return vec4<f32>(in.color, 1.0); // this WILL interpolate across the triangle
}
