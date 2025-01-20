module healthDecoder(health, out, bossHealth,boss);
	input[1:0] health;
	input[2:0] bossHealth;
	input boss;
	output[9:0] out;
	
	wire b2, b1, b0;
	
	assign b2=bossHealth[2];
	assign b1=bossHealth[1];
	assign b0=bossHealth[0];
	
	//Displays player current health
	assign out[0] = (health[1] & health[0])|(~health[1] & health[0])|(health[1] & ~health[0]);
	assign out[1] = (health[1] & health[0])|(health[1] & ~health[0]);
	assign out[2] = (health[1] & health[0]);
	
	//Displays boss health
	assign out[3]= 1'b0;
	assign out[4]= boss&(b2&b1&~b0);
	assign out[5]= boss&((b2&b1&~b0)|(b2&~b1&b0));
	assign out[6]= boss&((b2&b1&~b0)|(b2&~b1&b0)|(b2&~b1&~b0));
	assign out[7]= boss&((b2&b1&~b0)|(b2&~b1&b0)|(b2&~b1&~b0)|(~b2&b1&b0));
	assign out[8]= boss&((b2&b1&~b0)|(b2&~b1&b0)|(b2&~b1&~b0)|(~b2&b1&b0)|(~b2&b1&~b0));
	assign out[9]= boss&((b2&b1&~b0)|(b2&~b1&b0)|(b2&~b1&~b0)|(~b2&b1&b0)|(~b2&b1&~b0)|(~b2&~b1&b0));
endmodule