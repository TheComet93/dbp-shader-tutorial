// ----------------------------------------------------------------------------
// Projection matrices
// ----------------------------------------------------------------------------

float4x4 matWorldViewProjection : WORLDVIEWPROJECTION;

// ----------------------------------------------------------------------------
// Shader Constants
// ----------------------------------------------------------------------------

// determines how fat the character is
float fatness = 0.0f;

// ----------------------------------------------------------------------------
// Input and output structs
// ----------------------------------------------------------------------------

struct VS_INPUT
{
	float4 position : POSITION0;
	float2 texCoord : TEXCOORD0;
};

struct VS_OUTPUT
{
	float4 position : POSITION0;
	float2 texCoord : TEXCOORD0;
};

struct PS_INPUT
{
	float2 texCoord : TEXCOORD0;
};

struct PS_OUTPUT
{
	float4 colour : COLOR;
};

// ----------------------------------------------------------------------------
// Vertex shader
// ----------------------------------------------------------------------------

VS_OUTPUT vs_main( VS_INPUT input )
{
	// declare output struct, so we can write output data
	VS_OUTPUT output;

	// take each position attribute of the incoming vertex and transform it into projection space
	output.position = mul( input.position, matWorldViewProjection );

	// output texture coordinates
	output.texCoord = input.texCoord;

	// return output data
	return output;
}

// ----------------------------------------------------------------------------
// Pixel shader
// ----------------------------------------------------------------------------

PS_OUTPUT ps_main( PS_INPUT input )
{
	// declare output struct, so we can write output data
	PS_OUTPUT output;

	// set pixel colour according to the UV coordinate
	output.colour = float4( input.texCoord.xy, 1.0f, 1.0f );

	// output final colour
	return output;
}

// ----------------------------------------------------------------------------
// Techniques
// ----------------------------------------------------------------------------

technique Default
{
	pass p0
	{
		VertexShader = compile vs_1_1 vs_main();
		PixelShader = compile ps_1_1 ps_main();
	}
}