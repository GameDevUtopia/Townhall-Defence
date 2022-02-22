Many_Bullets={}
bulletSpeed=500
-- function CreateBullets()
-- 	Bullet={}
-- 	bullet.radius = 3
-- 	Bullet.x=player.x+player.width/2-Bullet.width/2
-- 	Bullet.y=player.y
-- 	Bullet.speed=800
-- 	Bullet.damage = 50
-- 	return Bullet
-- end


function Bullets_Movement(dt)
	for keys,values in pairs(Many_Bullets)do
		values.y=values.y+(values.dy*dt)
		values.x=values.x+(values.dx*dt)
	end
end

function Bullet_Draw()
  love.graphics.setColor(1,1,1)
	for k,v in pairs(Many_Bullets)do
		--love.graphics.circle("fill",v.x,v.y,v.radius)
		love.graphics.draw(player_bullet, v.x - 10, v.y - 10, 0, 20/player_bullet:getWidth(), 20/player_bullet:getHeight())
	end
end

function Bullet_Townhall()
	for keys,values in pairs(Many_Bullets)do
		bullet_th_distance = distance(values.x,values.y,townhall.x,townhall.y)
		if (bullet_th_distance<townhall.radius + values.radius) then
			townhall.hp = townhall.hp - 100
			
			table.remove(Many_Bullets,keys)
		end
	end
end

function distance(x1,y1,x2,y2)
  return math.sqrt((x2-x1)^2 + (y2-y1)^2)
end
