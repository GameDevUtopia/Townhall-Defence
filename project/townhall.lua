WINDOW_WIDTH = 1200
WINDOW_HEIGHT = 700

townhall = {}
townhall.x = WINDOW_WIDTH/2
townhall.y = WINDOW_HEIGHT/2
townhall.radius = 100
townhall.hp = 2500
townhall.shield = 2500

function townhall_state()
    if townhall.hp <= 0 then
        gamestate = 'gameover'
    end
    
end

-- will draw the townhall and call other functions
function draw_townhall()
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("line", townhall.x, townhall.y, townhall.radius)
    draw_townhall_hp()
    draw_townhall_shield()
end

-- will draw townhall shield
function draw_townhall_shield()
    love.graphics.setColor(1, 1, 1)
    --love.graphics.setLineWidth(10)
    --love.graphics.circle("line", townhall.x, townhall.y, townhall.radius)
    love.graphics.draw(townhall_image, townhall.x - townhall.radius, townhall.y - townhall.radius, 0, 2 * townhall.radius/townhall_image:getWidth(), 2 * townhall.radius/townhall_image:getHeight())
end

-- will draw the hp of townhall
-- this is done using two rectance one with "fill" and other with "line"
-- the one with fill you have to set its width by townhall.hp/townhall.shield * 2 * townhall.radius
function draw_townhall_hp()
    love.graphics.setLineWidth(1)
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle("line", townhall.x - townhall.radius, townhall.y - townhall.radius - 20, 2 * townhall.radius, 5)
    love.graphics.rectangle("fill", townhall.x - townhall.radius, townhall.y - townhall.radius - 20, townhall.hp/townhall.shield * 2 * townhall.radius, 5)
end
