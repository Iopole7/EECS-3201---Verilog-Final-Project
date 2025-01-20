module loop(cin, button, posVal, charVal, level,power,control,lvlLight,dmg, health, lose, win, player, boss, bossHealth,laserInd,laserPos,fireLaser, shape);
	input cin, power;
	input [1:0] button;
	input dmg;
	
	output reg player = 1'b0;
	output reg lvlLight = 1'b1;
	output reg control = 1'b0;
	output reg boss = 1'b0;
	output reg[1:0] level = 2'd0;
	output reg[1:0] charVal = 2'd0;
	output reg[1:0] shape = 2'd0;
	output reg[5:0] posVal = 6'd0;
	
	output reg [1:0] health = 2'd3;
	output reg [2:0] bossHealth = 3'd6;
	
	output reg [1:0] laserInd = 2'b11;
	output reg laserPos = 1'b0;
	output reg fireLaser = 1'b0;
	
	output reg lose = 1'b0;
	output reg win = 1'b0;
	
	reg[31:0] count = 32'd0;
	reg[22:0] delayCount= 23'b0;
	reg[31:0] blinkCount = 32'd0;
	reg[31:0] bossCount = 32'd0;
	reg[31:0] laserCount = 32'd0;
	reg delay = 0;
	reg[3:0] lvlCounter = 4'd0;
	reg[3:0] bossHits = 4'd0;
	reg gen = 0;
	
	reg[3:0] val1 = 4'd0;
	reg[3:0] val2 = 4'd2;
	
	parameter C = 32'd50000000;
	parameter D = 23'd5000000;
	parameter E = 32'd10000000;
	parameter F = 32'd45000000;
	parameter G = 2'd3;
	
	//Difficulty settings
	//Number of blocks for level 1
	reg [3:0] lvl = 4'd4;
	//Base speed
	integer j = 24000000;
	//Speed increment
	integer k = 8000000;
	
	always @(posedge cin) begin
	//Allows game to be paused
		if(power == 1 && win == 1'b0 && lose == 1'b0)begin
			//Detect inputs for top button allowing player to move up. Makes sure player cannot move past top segment
			if(button[1] == 0 && delay == 0)begin
				if(charVal < 2'd3)begin
					delay <= 1;
					charVal <= charVal + 1;
				end
			end
			//Detect inputs for bottom button allowing player to move down. Makes sure player cannot move past bottom segment
			if(button[0] == 0 && delay == 0)begin
				if(charVal > 2'd0) begin
					delay <=1 ;
					charVal <= charVal - 1;
				end
			end
			
			//Debounces both button
			if(delay == 1)
				delayCount <= delayCount + 23'b1;
			if(delayCount >= D-1)begin
				delayCount <= 23'd0;
				delay <= 0;
			end
			
			//Controls player blinking
			blinkCount <= blinkCount + 32'd1;
			if(blinkCount >= E-1)begin
				blinkCount <= 32'd0;
				if(player == 1'b1)
					player <= 1'b0;
				else if(player == 1'b0)
					player <= 1'b1;
			end
			
			//Block generation and movement form levels 1-3
			count <= count + 32'd1;
			if (count  >= C-j && control == 1'b0)
			begin
				//Continues only if not level 4
				if(lvlCounter == lvl && level < 3)begin
					level = level + 2'd1;
					if(level >= 3)
						control = 1'b1;
					lvlCounter <= 4'd0;
					j = j+k;
					lvl <= lvl+4'd4;
				end
				
				//Moves blocks across the displays
				count <= 32'd0;
				if(posVal == 6'd0)begin
					posVal <= 6'd1;
					if(lvlCounter == lvl-1)
						lvlLight <= 1'b0;
				end
				else if(posVal == 6'd1)
					posVal <= 6'd2;
				else if(posVal == 6'd2)
					posVal <= 6'd4;
				else if(posVal == 6'd4)
					posVal <= 6'd8;
				else if(posVal == 6'd8)
					posVal <= 6'd16;
				else if(posVal == 6'd16)
					posVal <= 6'd32;
				else if(posVal == 6'd32) begin
					posVal <= 6'd0;
					lvlLight <= 1'b1;
					lvlCounter <= lvlCounter + 4'd1;
					//Increment damage
					if(dmg == 1 && power == 1)
						health = health - 1;
					//Randomize next block
					shape <= val1 ^ val2;
					if(charVal < 3)
						val1 <= charVal+1;
					else
						val1 <= charVal;
					val2 <= val2 + 1;
				end
			end
			
			//Controls boss
			if(control == 1'b1 && level >= 3)begin
				boss <= 1'b1;
				bossCount <= bossCount + 32'd1;
				laserCount <= laserCount +32'd1;
				//Boss health counter
				if(bossCount >= C-1)begin
					bossHits <= bossHits + 1;
					bossCount <= 32'd0;
				end
				if(bossHits >= 4'd4)begin
					if(bossHealth > 3'd0)
						bossHealth <= bossHealth - 3'd1;
					bossHits <= 4'd0;
				end
				
				//Controls firing laser
				if(laserCount >= F-1)begin
					laserCount <= 32'd0;
					
					if(gen == 1)begin
						fireLaser <= 1'b1;
						laserInd <= 2'b11;
						gen <= 0;
					end
					if(gen == 0)begin
						if(dmg == 1)
							health = health - 1;
						laserPos <= ~laserPos;
						fireLaser <= 1'b0;
						gen <= 1;
						if(laserPos == 1)
							laserInd <= 2'b01;
						if(laserPos == 0)
							laserInd <= 2'b10;
					end
				end	
				
			end
			
			
		end
		
		//Controls end state
		if(health <= 2'b0)begin
			lose <= 1'b1;
			boss <= 1'b0;
			laserInd <= 2'b11;
		end
		if(bossHealth <= 3'd0)begin
			win <= 1'b1;
			boss <= 1'b0;
			laserInd <= 2'b11;
		end
	end
endmodule