module Lab2(clk, button, light, dis, switch,levelLight,laserLight);
	input clk, switch;
	input [1:0] button;
	output levelLight;
	output[1:0] laserLight;
	output [41:0] dis;
	output [9:0] light;
	
	//Wires for position value for blocks
	wire p0, p1, p2, p3, p4, p5;
	//Wires for possition value for character
	wire char0, char1;
	//Wires for shape
	wire s1, s0;
	//Wires for level control
	wire l1, l0;
	//Wire for pausing game
	wire control;
	//Wire for damage
	wire dmg;
	//Wire for danger states
	wire del1, del2, del3, del4;
	//Wire for player health
	wire h1, h0;
	//Wire for if win or loss
	wire win, lose;
	//Wire for blinking of player
	wire plstat;
	//Wire for boss enable
	wire boss;
	//Wire for boss health
	wire bh2, bh1, bh0;
	//Wire for laser position
	wire lasPos;
	//Wire for fire enable
	wire fire;
	
	loop cont(clk, {button[1], button[0]},{p5, p4, p3, p2, p1, p0},
	{char1, char0},{l1, l0},switch,control,levelLight,dmg, {h1, h0},
	lose, win,plstat,boss,{bh2, bh1, bh0},{laserLight[1],laserLight[0]}, lasPos, fire,{s1, s0});
	
	blockDecoder dec({l1, l0}, {dis[41:0]}, {s1, s0},{p5, p4, p3, p2, p1, p0},
	{char1, char0},control, {del4, del3, del2, del1}, plstat, boss, lasPos, fire, win, lose);
	
	collisionDectector dect({char1, char0},{del4, del3, del2, del1}, dmg);
	
	healthDecoder hlthDec({h1, h0},
	{light[9],light[8],light[7],light[6],light[5],light[4],light[3],light[2],light[1],light[0]},{bh2,bh1,bh0},boss);

	endmodule