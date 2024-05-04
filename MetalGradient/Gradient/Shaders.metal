#include <metal_stdlib>
using namespace metal;

// just draw a rectangle
vertex float4 vertexShader(uint vertexID [[vertex_id]]) {
    float2 vertices[6] = {
        float2(-1.0, -1.0),
        float2(1.0, -1.0),
        float2(-1.0, 1.0),
        float2(1.0, -1.0),
        float2(1.0, 1.0),
        float2(-1.0, 1.0),
    };

    float2 position = vertices[vertexID];

    // Pass the already normalized screen-space coordinates to the rasterizer
    return float4(position, 0, 1);
}

fragment float4 fragmentShader(float4 position [[position]]) {
    return float4(1, 0, 0, position.x / 800);
}
