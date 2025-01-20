module endDisp(lose, win, dis);
	input lose, win;
	output [41:0] dis;
	
	assign dis[0] = ~lose | ~win;	
	assign dis[1] = lose;
	
	assign dis[41:28] = 1'b1;

endmodule