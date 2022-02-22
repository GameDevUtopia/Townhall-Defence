
enemyBullet = {}

function createEnemyBullet(argument)
    bullet = {}
    bullet.radius = 5
    bullet.x = argument.x
    bullet.y = argument.y
    bullet.slope = argument.slope
    bullet.xincrement = argument.xincrement * 10
    bullet.yincrement = argument.yincrement * 10
    --bullet.speed = 10
    bullet.damage = 100
    
    table.insert(enemyBullet, bullet)
end


function update_bullet(dt)
    for key, value in pairs(enemyBullet)do
        value.x = value.x + value.xincrement * dt
        value.y = value.y + value.yincrement * dt
    end
    
end


function shoot_bullet()
    for key, value in pairs(EnemyTable)do
        createEnemyBullet(value)
    end
    
    draw_enemy_bullet()
    
end



function delete_bullet()
    for key, value in pairs(enemyBullet)do
        if math.sqrt(math.pow(townhall.x - value.x, 2) + math.pow(townhall.y - value.y, 2)) < townhall.radius + value.radius then
            table.remove(enemyBullet, key)
            townhall.hp = townhall.hp - 10
            
        end
    end    
end

function draw_enemy_bullet()
    love.graphics.setColor(1, 1, 1)
    for key, value in pairs(enemyBullet)do
        --love.graphics.circle("fill", value.x, value.y, value.radius)
        love.graphics.draw(enemy_bullet_image, value.x - 10, value.y - 10, 0, 20/enemy_bullet_image:getWidth(), 20/enemy_bullet_image:getHeight())
    end
end