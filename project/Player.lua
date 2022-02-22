player={}
player.width=40
player.height=40
player.x=WINDOW_WIDTH/2-player.width/2
player.y=WINDOW_HEIGHT-player.height
player.speed=100
player.hp = 1000
player.health = 1000

function Player_Movement(dt)
	if(love.keyboard.isDown("w"))then
		-- check upper right point of player rectangle
		local distance_player_th_right=distance(player.x+player.width,player.y,townhall.x,townhall.y)
		-- check upper left point of player rectangle
		local distance_player_th_left=distance(player.x,player.y,townhall.x,townhall.y)
		local angle1 = math.atan2((player.y-townhall.y), (player.x+player.width-townhall.x))
		local angle2 = math.atan2((player.y-townhall.y), (player.x-townhall.x))
			if distance_player_th_right<townhall.radius+1 then
				player.y=townhall.y+(townhall.radius*(math.sin(angle1)))
			else
				player.y=math.max(0,player.y-player.speed*dt)
			end
			if distance_player_th_left<townhall.radius+1 then
				player.y=townhall.y+(townhall.radius*(math.sin(angle2)))
			else
				player.y=math.max(0,player.y-player.speed*dt)
			end
	-- 	if player.x+player.width>townhall.x-townhall.radius and player.x<townhall.x+townhall.radius then
	-- 		if player.y+player.height>WINDOW_HEIGHT/2 then
	-- 			if player.y<=townhall.y+townhall.radius then
	-- 				player.y=townhall.y+townhall.radius+1
	-- 			else
	-- 				player.y=math.max(0,player.y-player.speed*dt)
	-- 			end
	-- 		end
	-- 	else
	-- 		player.y=math.max(0,player.y-player.speed*dt)
	-- 	end
	end
	if(love.keyboard.isDown("s"))then
		-- check lower right point of player rectangle
		local distance_player_th_right=distance(player.x+player.width,player.y+player.height,townhall.x,townhall.y)
		-- check lower left point of player rectangle
		local distance_player_th_left=distance(player.x,player.y+player.height,townhall.x,townhall.y)
		local angle1 = math.atan2((player.y+player.height-townhall.y), (player.x+player.width-townhall.x))
		local angle2 = math.atan2((player.y+player.height-townhall.y), (player.x-townhall.x))
			if distance_player_th_right<townhall.radius+1 then
				player.y=townhall.y-(townhall.radius*(-math.sin(angle1)))-player.height
			else
				player.y=math.min(WINDOW_HEIGHT-player.height,player.y+player.speed*dt)
			end
			if distance_player_th_left<townhall.radius+1 then
				player.y=townhall.y-(townhall.radius*(-math.sin(angle2)))-player.height
			else
				player.y=math.min(WINDOW_HEIGHT-player.height,player.y+player.speed*dt)
			end
	-- 	if player.x+player.width>townhall.x-townhall.radius and player.x<townhall.x+townhall.radius then
	-- 		if player.y+player.height<WINDOW_HEIGHT/2 then
	-- 			if player.y+player.height>=townhall.y-townhall.radius then
	-- 				player.y=townhall.y-townhall.radius-player.height-1
	-- 			else
	-- 				player.y=math.min(WINDOW_HEIGHT-player.height,player.y+player.speed*dt)
	-- 			end
	-- 		end
	-- 	else
	-- 		player.y=math.min(WINDOW_HEIGHT-player.height,player.y+player.speed*dt)
	-- 	end
	end

	if(love.keyboard.isDown("a"))then
		-- check lower left point of player rectangle
		local distance_player_th_low=distance(player.x,player.y+player.height,townhall.x,townhall.y)
		-- check upper left point of player rectangle
		local distance_player_th_high=distance(player.x,player.y,townhall.x,townhall.y)
		local angle1 = math.atan2((player.y+player.height-townhall.y), (player.x-townhall.x))
		local angle2 = math.atan2((player.y-townhall.y), (player.x-townhall.x))
		if distance_player_th_low<townhall.radius+5 then
			player.x=townhall.x+(townhall.radius*math.cos(angle1))+5
		else
			player.x=math.max(0,player.x-player.speed*dt)
		end
		if distance_player_th_high<townhall.radius+5 then
			player.x=townhall.x+(townhall.radius*math.cos(angle2))+5
		else
			player.x=math.max(0,player.x-player.speed*dt)
		end

	-- 	if player.y+player.height>townhall.y-townhall.radius and player.y<townhall.y+townhall.radius then
	-- 		if player.x+player.width>WINDOW_WIDTH/2 then
	-- 			if player.x<=townhall.x+townhall.radius then
	-- 				player.x=townhall.x+townhall.radius+1
	-- 			else
	-- 				player.x=math.max(0,player.x-player.speed*dt)
	-- 			end
	-- 		end
	-- 	else
	-- 		player.x=math.max(0,player.x-player.speed*dt)
	-- 	end
	end
	if(love.keyboard.isDown("d"))then
		-- check lower left point of player rectangle
		local distance_player_th_low=distance(player.x+player.width,player.y+player.height,townhall.x,townhall.y)
		-- check upper right point of player rectangle
		local distance_player_th_high=distance(player.x+player.width,player.y,townhall.x,townhall.y)
		local angle1 = math.atan2((player.y+player.height-townhall.y), (player.x+player.width-townhall.x))
		local angle2 = math.atan2((player.y-townhall.y), (player.x+player.width-townhall.x))
			if distance_player_th_low<townhall.radius+1 then
				player.x=townhall.x-(townhall.radius*(-math.cos(angle1)))-player.width
			else
				player.x=math.min(WINDOW_WIDTH-player.width,player.x+player.speed*dt)
			end
			if distance_player_th_high<townhall.radius+1 then
				player.x=townhall.x-(townhall.radius*(-math.cos(angle2)))-player.width
			else
				player.x=math.min(WINDOW_WIDTH-player.width,player.x+player.speed*dt)
			end
		end
			-- if player.y+player.height>townhall.y-townhall.radius and player.y<townhall.y+townhall.radius then
			-- 	if player.x +player.width<WINDOW_WIDTH/2 then
			-- 		if player.x+player.width>=townhall.x-townhall.radius then
			-- 			player.x=townhall.x-townhall.radius-player.width-1
			-- 		else
			-- 			player.x=math.min(WINDOW_WIDTH-player.width,player.x+player.speed*dt)
			-- 		end
			-- 	end
			-- else
			-- 	player.x=math.min(WINDOW_WIDTH-player.width,player.x+player.speed*dt)
			-- end
	if player.hp <= 0 then
		gamestate = "gameover"
	end

end

function Player_Draw()
	--love.graphics.setColor(2,0,2)
	love.graphics.setLineWidth(1)
	--love.graphics.rectangle("fill",player.x,player.y,player.width,player.height)
	love.graphics.draw(player_image, player.x, player.y, 0, player.width/player_image:getWidth(), player.height/player_image:getHeight())
	love.graphics.setColor(0, 1, 0)

	love.graphics.rectangle("line", player.x, player.y - 20, 40, 5)
	
	love.graphics.rectangle("fill", player.x, player.y - 20, player.hp/player.health * 40, 5)
end

function distance(x1,y1,x2,y2)
  return math.sqrt((x2-x1)^2 + (y2-y1)^2)
end






-- if player.y>townhall.y-townhall.radius and player.y+player.height<townhall.y+townhall.radius then
-- 	if player.x+player.width+1==(WINDOW_WIDTH/2)-townhall.radius then
-- 		player.x=townhall.x-townhall.radius-player.width-1
-- 	end
-- end
