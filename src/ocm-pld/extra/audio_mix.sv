module audio_mixer
(
input	 wire [9:0]pAudioPSG,
input	 wire [13:0]pAudioOPLL,
input	 wire [15:0]pAudioPCM,
input	 wire [15:0]pAudioOPL3,
input	 wire [10:0]pAudioTAPE,
output wire [15:0]pDacOut
);

wire [16:0] pcm   = {pAudioPCM[15], pAudioPCM};
wire [15:0] fm    = {pAudioOPLL, 2'b00} + {1'b0, pAudioPSG, 5'b00000} + pAudioOPL3;
wire [16:0] audio = {pcm[16], pcm[16:1]} + {fm[15], fm};
wire [15:0] compr[7:0] = '{ {1'b1, audio[13:0], 1'b0}, 16'h8000, 16'h8000, 16'h8000, 16'h7FFF, 16'h7FFF, 16'h7FFF,  {1'b0, audio[13:0], 1'b0}};
wire [15:0] dac_out = compr[audio[16:14]];
assign pDacOut = dac_out;

endmodule
