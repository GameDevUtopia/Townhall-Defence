--require 'bullets'
EnemyTable = {}
d = math.sqrt(math.pow(player.width/2, 2) + math.pow(player.height/2, 2))

function createEnemy()
    enemy = {}
    --enemy.width = 20
    --enemy.height = 20
    enemy.radius = 20
    random = math.random()
    if random < 0.25 then
        enemy.x = math.random(0, WINDOW_WIDTH - enemy.radius)
        enemy.y = math.random(-50, 0)
    elseif random < 0.5 then
        enemy.x = math.random(0, WINDOW_WIDTH - enemy.radius)
        enemy.y = math.random(WINDOW_HEIGHT, WINDOW_HEIGHT + 50)
    elseif random < 0.75 then
        enemy.x = math.random(-50, 0)
        enemy.y = math.random(0, WINDOW_HEIGHT - enemy.radius)
    elseif random < 1 then
        enemy.x = math.random(WINDOW_WIDTH, WINDOW_WIDTH + 50)
        enemy.y = math.random(0, WINDOW_HEIGHT - enemy.radius)
        
    end
    --enemy.x = math.random(-50, 0)
    --enemy.y = math.random(0, WINDOW_HEIGHT - enemy.height)
    --enemy.speed = 500
    enemy.timeinterval = math.random(60, 120)
    enemy.slope = (townhall.y - enemy.y)/(townhall.x - enemy.x)
    if enemy.slope > 5 then
        enemy.slope = 5
    elseif enemy.slope < -5 then
        enemy.slope = -5
    end
    if enemy.x < WINDOW_WIDTH/2 then
        enemy.xincrement = 0.2 * 100
        enemy.yincrement = enemy.slope * enemy.xincrement 
    else
        enemy.xincrement = -0.2 * 100
        enemy.yincrement = (enemy.slope * enemy.xincrement)
    end
    enemy.hp = 50
    enemy.health = 50
    table.insert(EnemyTable, enemy)
end




function enemy_movement(dt)
    for key, value in pairs(EnemyTable) do
        value.x = value.x + value.xincrement * dt
        value.y = value.y + value.yincrement * dt
        delete_enemy()
    end
end

function delete_enemy()
    for key, value in pairs(EnemyTable)do
        -- if value.x > WINDOW_WIDTH + 50 or value.x < -50 or value.y > WINDOW_HEIGHT + 50 or value.y < -50 then
        --     table.remove(EnemyTable, key)
        --     totalenemy = totalenemy - 1
        -- end
        if math.sqrt(math.pow(townhall.x - value.x, 2) + math.pow(townhall.y - value.y, 2)) < townhall.radius + value.radius then
            table.remove(EnemyTable, key)
            townhall.hp = townhall.hp - 100
            crash_sound:play()
            totalenemy = totalenemy - 1
        end
    end
    
    
end

function check_enemy_bullet_player_collision()
    for key, value in pairs(enemyBullet)do
        if distance(value.x, value.y, player.x + player.width/2, player.y + player.height/2) < value.radius + d then
            player.hp = player.hp - value.damage
            table.remove(enemyBullet, key)
        end
    end
    
end

function check_player_bullet_enemy_collision()
    for key, value in pairs(EnemyTable)do
        for key1, value1 in pairs(Many_Bullets)do
            if value1.x > WINDOW_WIDTH or value1.x < 0 or value1.y < 0 or value1.y > WINDOW_HEIGHT then
                table.remove(Many_Bullets, key1)
            end
            if distance(value.x, value.y, value1.x, value1.y) < value.radius + value1.radius then
                table.remove(EnemyTable, key)
                totalenemy = totalenemy - 1
                table.remove(Many_Bullets, key1)
                
            end 
            
        end
        
        if distance(value.x, value.y, player.x + player.width/2, player.y + player.height/2) < value.radius + d then
            table.remove(EnemyTable, key)
            totalenemy = totalenemy - 1
            player.hp = player.hp - 100
        end
    end
    
end


function enemyDraw()
    love.graphics.setColor(1, 1, 1)
    for key, value in pairs(EnemyTable) do
        --love.graphics.circle("fill" ,value.x, value.y, value.radius)
        love.graphics.draw(enemy_image, value.x - value.radius, value.y - value.radius, 0, 2 * enemy.radius/enemy_image:getWidth(), 2 * enemy.radius/enemy_image:getHeight())
    end
    --love.graphics.print(tostring(totalenemy), 30, 30)
end
