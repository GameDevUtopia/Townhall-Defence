WINDOW_WIDTH = 1200
WINDOW_HEIGHT = 700

play_button = {}
play_button.width = 255/2
play_button.height = 84/2
play_button.x = WINDOW_WIDTH/2 - 255/4
play_button.y = WINDOW_HEIGHT/2 - 84/4

-- calls the function to draw on the screen
function draw_main_menu()
    draw_button()
    draw_game_name()
end

-- to check if player has clicked on the play button
function love.mousepressed(x, y, button)
    x,y =push:toGame(x, y)
    if button == 1 then
        if x ~= nil and y~= nil then
            if x > play_button.x and x < play_button.x + play_button.width and y > play_button.y and y < play_button.y + play_button.height then
                gamestate = "instructions"
                instructions_timer = 0
                EnemyTable = {}
            end
        end
        
    end
end

-- will draw the play button
function draw_button()
    love.graphics.setColor(1, 1, 1)
    --love.graphics.setFont(love.graphics.newFont(40))
    --love.graphics.rectangle("fill", WINDOW_WIDTH/2 - 40, WINDOW_HEIGHT/2, 100, 50, 10, 10)
    --love.graphics.setColor(1, 1 ,1)
    --love.graphics.print("Play", WINDOW_WIDTH/2 - 30, WINDOW_HEIGHT/2)
    love.graphics.draw(play_button_ui, play_button.x, play_button.y,0,  play_button.width/play_button_ui:getWidth(), play_button.height/play_button_ui:getHeight())
end

-- will write the game name
function draw_game_name()
    --love.graphics.newFont(100)
    --love.graphics.print("GameName", WINDOW_WIDTH/2 - 100, 200)
    love.graphics.draw(game_name_image, WINDOW_WIDTH/2 - 538/2, WINDOW_HEIGHT/2 - 185/2 - 200)
    
end