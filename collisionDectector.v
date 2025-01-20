module collisionDectector(char, blockPos, dmg);
	input [1:0] char;
	input [3:0] blockPos;
	output dmg;
	
	
	wire c1, c2, c3, c4;
	
	assign c1 = (char[0]|char[1]);
	assign c2 = (~char[0]|~char[1]);
	assign c3 = (char[0]|~char[1]);
	assign c4 = (~char[0]|char[1]);
	
	//Compares current player position with danger states
	assign dmg = (~c1 & ~blockPos[0]) | (~c2 & ~blockPos[1]) | (~c3 & ~blockPos[2]) | (~c4 & ~blockPos[3]);
endmodule