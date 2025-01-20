module blockDecoder(level, out, shape, pos, char, enable, delVals, sta,boss, lasPos, fire, win, lose);
	input [1:0] level;
	input [1:0] shape;
	input [5:0] pos;
	input [1:0] char;
	input fire;
	input lasPos;
	input sta;
	input boss;
	input win, lose;
	output [41:0] out;
	output [3:0] delVals;
	input enable;
	
	wire l0, l1, r0, r1, e;
	
	
	assign l0 = level[0];
	assign l1 = level[1];
	assign r0 = shape[0];
	assign r1 = shape[1];
	assign e = enable;
	
	//Decodes values for the first display(From the right). It takes the level and shape and deciphers which segements
	//to display values on.
	assign out[0] = ~win&~lose&(e | (~pos[0]| ((l1|l0|r0|r1)&(l1|~l0|r1|r0)&(~l1|l0|r0|r1)&(~l1|l0|~r1|r0))));
	assign out[1] = ~win;
	assign out[2] = ~win;
	assign out[3] = ~lose&(e | (~pos[0] | (l1|l0|~r1|~r0)&(l1|~l0|r1|~r0)&(l1|~l0|~r1|r0)&(~l1|l0|~r1|r0)&(~l1|l0|~r1|~r0)));
	assign out[4] = ~win&~lose&~boss&(e | (~pos[0] | (~l1&~l0&~r1&~r0)|(~l1&~l0&~r1&r0)|(~l1&~l0&r1&r0)|(~l1&l0&~r1&~r0)|(~l1&l0&r1&~r0)));
	assign out[5] = ~win&~lose&~boss&(e | (~pos[0] | (~l1&~l0&~r1&~r0)|(~l1&~l0&r1&~r0)|(~l1&~l0&r1&r0)|(~l1&l0&~r1&r0)|(l1&~l0&r1&~r0)));
	assign out[6] = ~lose&~boss;
	
	//Decodes values for second seven segent display(From the right)
	assign out[7] = ~lose&~boss&(e|~pos[1] | ((l1|l0|r0|r1)&(l1|~l0|r1|r0)&(~l1|l0|r0|r1)&(~l1|l0|~r1|r0)));
	assign out[8] = ~win&~boss;
	assign out[9] = ~win&~lose&~boss;
	assign out[10] = ~lose&~boss&(e|~pos[1] | (l1|l0|~r1|~r0)&(l1|~l0|r1|~r0)&(l1|~l0|~r1|r0)&(~l1|l0|~r1|r0)&(~l1|l0|~r1|~r0));
	assign out[11] = ~boss&(e|~pos[1] | (~l1&~l0&~r1&~r0)|(~l1&~l0&~r1&r0)|(~l1&~l0&r1&r0)|(~l1&l0&~r1&~r0)|(~l1&l0&r1&~r0));
	assign out[12] = ~lose&~boss&(e|~pos[1] | (~l1&~l0&~r1&~r0)|(~l1&~l0&r1&~r0)|(~l1&~l0&r1&r0)|(~l1&l0&~r1&r0)|(l1&~l0&r1&~r0));
	assign out[13] = ~lose&~boss;
	
	//Decodes values for third seven segent display(From the right)
	assign out[14] = ~lose& (~boss|~fire|~lasPos)&(e|~pos[2] | ((l1|l0|r0|r1)&(l1|~l0|r1|r0)&(~l1|l0|r0|r1)&(~l1|l0|~r1|r0)));
	assign out[15] = ~win&~lose;
	assign out[16] = ~win&~lose;
	assign out[17] = ~win&~lose&(~boss|~fire|lasPos)&(e|~pos[2] | (l1|l0|~r1|~r0)&(l1|~l0|r1|~r0)&(l1|~l0|~r1|r0)&(~l1|l0|~r1|r0)&(~l1|l0|~r1|~r0));
	assign out[18] = ~lose&(e|~pos[2] | (~l1&~l0&~r1&~r0)|(~l1&~l0&~r1&r0)|(~l1&~l0&r1&r0)|(~l1&l0&~r1&~r0)|(~l1&l0&r1&~r0));
	assign out[19] = ~lose&(e|~pos[2] | (~l1&~l0&~r1&~r0)|(~l1&~l0&r1&~r0)|(~l1&~l0&r1&r0)|(~l1&l0&~r1&r0)|(l1&~l0&r1&~r0));
	assign out[20] = (~boss|~fire);
	
	//Decodes values for fourth seven segent display(From the right)
	assign out[21] = (~boss|~fire|~lasPos)&(e|~pos[3] | ((l1|l0|r0|r1)&(l1|~l0|r1|r0)&(~l1|l0|r0|r1)&(~l1|l0|~r1|r0)));
	assign out[22] = ~win;
	assign out[23] = ~win;
	assign out[24] = ~win&~lose&(~boss|~fire|lasPos)&(e|~pos[3] | (l1|l0|~r1|~r0)&(l1|~l0|r1|~r0)&(l1|~l0|~r1|r0)&(~l1|l0|~r1|r0)&(~l1|l0|~r1|~r0));
	assign out[25] = ~win&~lose&(e|~pos[3] | (~l1&~l0&~r1&~r0)|(~l1&~l0&~r1&r0)|(~l1&~l0&r1&r0)|(~l1&l0&~r1&~r0)|(~l1&l0&r1&~r0));
	assign out[26] = ~win&~lose&(e|~pos[3] | (~l1&~l0&~r1&~r0)|(~l1&~l0&r1&~r0)|(~l1&~l0&r1&r0)|(~l1&l0&~r1&r0)|(l1&~l0&r1&~r0));
	assign out[27] = (~boss|~fire);
	
	//Decodes values for fifth seven segent display(From the right)
	assign out[28] = (~boss|~fire|~lasPos)&(e|~pos[4] | ((l1|l0|r0|r1)&(l1|~l0|r1|r0)&(~l1|l0|r0|r1)&(~l1|l0|~r1|r0)));
	assign out[29] = 1'b1;
	assign out[30] = 1'b1;
	assign out[31] = (~boss|~fire|lasPos)&(e|~pos[4] | (l1|l0|~r1|~r0)&(l1|~l0|r1|~r0)&(l1|~l0|~r1|r0)&(~l1|l0|~r1|r0)&(~l1|l0|~r1|~r0));
	assign out[32] = e|~pos[4] | (~l1&~l0&~r1&~r0)|(~l1&~l0&~r1&r0)|(~l1&~l0&r1&r0)|(~l1&l0&~r1&~r0)|(~l1&l0&r1&~r0);
	assign out[33] = e|~pos[4] | (~l1&~l0&~r1&~r0)|(~l1&~l0&r1&~r0)|(~l1&~l0&r1&r0)|(~l1&l0&~r1&r0)|(l1&~l0&r1&~r0);
	assign out[34] = (~boss|~fire);
	
	//Decodes values for sixth seven segent display(From the right). It also takes in values to decipher where the player
	//character should be placed regardless of where the blocks will be.
	assign out[35] = (~boss|~fire|~lasPos)&((char[0]|char[1]|sta) & (e|(~pos[5] | ((l1|l0|r0|r1)&(l1|~l0|r1|r0)&(~l1|l0|r0|r1)&(~l1|l0|~r1|r0)))));
	assign out[36] = 1'b1;
	assign out[37] = 1'b1;
	assign out[38] = (~boss|~fire|lasPos)&((~char[0]|~char[1]|sta) & (e|(~pos[5] | (l1|l0|~r1|~r0)&(l1|~l0|r1|~r0)&(l1|~l0|~r1|r0)&(~l1|l0|~r1|r0)&(~l1|l0|~r1|~r0))));
	assign out[39] = (~boss|~fire|lasPos)&((char[0]|~char[1]|sta) & (e|(~pos[5] | (~l1&~l0&~r1&~r0)|(~l1&~l0&~r1&r0)|(~l1&~l0&r1&r0)|(~l1&l0&~r1&~r0)|(~l1&l0&r1&~r0))));
	assign out[40] = (~boss|~fire|~lasPos)&((~char[0]|char[1]|sta) & (e|(~pos[5] | (~l1&~l0&~r1&~r0)|(~l1&~l0&r1&~r0)|(~l1&~l0&r1&r0)|(~l1&l0&~r1&r0)|(l1&~l0&r1&~r0))));
	assign out[41] = (~boss|~fire);
	
	//Outputs danger states that would cause player to lose health
	assign delVals[0] =(~boss|~fire|~lasPos)&((l1|l0|r0|r1)&(l1|~l0|r1|r0)&(~l1|l0|r0|r1)&(~l1|l0|~r1|r0));
	assign delVals[1] =(~boss|~fire|lasPos)&((l1|l0|~r1|~r0)&(l1|~l0|r1|~r0)&(l1|~l0|~r1|r0)&(~l1|l0|~r1|r0)&(~l1|l0|~r1|~r0));
	assign delVals[2] =(~boss|~fire|lasPos)&((~l1&~l0&~r1&~r0)|(~l1&~l0&~r1&r0)|(~l1&~l0&r1&r0)|(~l1&l0&~r1&~r0)|(~l1&l0&r1&~r0));
	assign delVals[3] =(~boss|~fire|~lasPos)&((~l1&~l0&~r1&~r0)|(~l1&~l0&r1&~r0)|(~l1&~l0&r1&r0)|(~l1&l0&~r1&r0)|(l1&~l0&r1&~r0));
	
endmodule