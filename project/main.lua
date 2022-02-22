require 'townhall'
require 'main_menu'
--my addition
require 'Player'
require 'Bullets'
--
require 'enemy'
require 'enemy_bullet'
push = require 'push'

WINDOW_WIDTH = 1200
WINDOW_HEIGHT = 700
timer = 0

function love.load()

    --love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)
    VIRTUAL_WIDTH,VIRTUAL_HEIGHT = love.window.getMode()

    gamestate = "main_menu"
    math.randomseed(os.time())
    enemy_image = love.graphics.newImage('assets/enemy1.png')
    play_button_ui = love.graphics.newImage('assets/play_button.png')
    player_image = love.graphics.newImage('assets/player.png')
    townhall_image = love.graphics.newImage('assets/townhall.png')
    gameover_image = love.graphics.newImage('assets/gameover.png')
    main_menu_image = love.graphics.newImage('assets/return_to_main_menu.png')
    winning_screen_image = love.graphics.newImage('assets/winning_screen.png')
    game_name_image = love.graphics.newImage('assets/game_name.png')
    player_bullet = love.graphics.newImage('assets/player_bullet.png')
    enemy_bullet_image = love.graphics.newImage('assets/enemy_bullet.png')
    background_image = love.graphics.newImage('assets/background.jpg')
    instructions_image = love.graphics.newImage('assets/instructions.png')
    background_music = love.audio.newSource('assets/music.mp3', 'stream')
    crash_sound = love.audio.newSource('assets/crash_sound.wav', "static")
    totalenemy = 0
    max_enemy = 0
    push:setupScreen(WINDOW_WIDTH,WINDOW_HEIGHT,VIRTUAL_WIDTH, VIRTUAL_HEIGHT,{
      vsync = true,
      fullscreen = true,
      resizable = true,
    })
end

function love.resize(w, h)
  push:resize(w, h)
  
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'm' then
      if gamestate == 'gameover' then
        gamestate = "main_menu"
      elseif gamestate == "winner" then
        gamestate = "main_menu"
        totalenemy = 0
        max_enemy = 0
      end
      
    end
end


function love.update(dt)
  background_music:play()
  background_music:setLooping(true)
  
  timer = timer + dt
  --my addition archies
  if gamestate == "play" then
    Bullets_Movement(dt)
    Bullet_Townhall()
    Player_Movement(dt)
    update_bullet(dt)
    delete_bullet()
    check_player_bullet_enemy_collision()
    check_enemy_bullet_player_collision()
    if totalenemy < 25 and max_enemy <= 70 then
      createEnemy()
      totalenemy = totalenemy + 1
      max_enemy = max_enemy + 1
      
    end
    
    enemy_movement(dt)
    if timer > 6 then
      shoot_bullet()
      timer = 0
    end
    
    --bullet
    function love.mousepressed(x, y, button, isTouch)
      if button==1 and gamestate == "play" then
        local startX = player.x + player.width / 2
    		local startY = player.y + player.height / 2
    		mouseX, mouseY = push:toGame(x, y)
    		
        if mouseX~= nil and mouseY ~= nil then
          local angle = math.atan2((mouseY - startY), (mouseX - startX))
          local bulletDx = bulletSpeed * math.cos(angle)
    		  local bulletDy = bulletSpeed * math.sin(angle)
          table.insert(Many_Bullets, {x = startX, y = startY, dx = bulletDx, dy = bulletDy, radius = 10})
        end
    		

    		

    		
      elseif button == 1 and gamestate == "main_menu" then
        mouseX, mouseY = push:toGame(x, y)
        if mouseX ~= nil and mouseY ~= nil then
          if mouseX > play_button.x and mouseX < play_button.x + play_button.width and mouseY > play_button.y and mouseY < play_button.y + play_button.height then
            gamestate = "instructions"
            instructions_timer = 0
            totalenemy = 0
            max_enemy = 0
            townhall.hp = 2500
            player.hp = 1000
            player = {}
            player.width=40
            player.height=40
            player.x=WINDOW_WIDTH/2-player.width/2
            player.y=WINDOW_HEIGHT-player.height
            player.speed=100
            player.hp = 1000
            player.health = 1000
            EnemyTable = {}
            Many_Bullets = {}
            enemyBullet = {}
        end
        end
        
      end
    end
    townhall_state()
  elseif gamestate == 'instructions' then
    instructions_timer = instructions_timer + dt
    if instructions_timer > 8 then
      gamestate = 'play'
    end 
    
  end
  if totalenemy == 0 and max_enemy == 71 then
    gamestate = "winner"
  end
end

function love.draw()
  push:start()
  love.graphics.draw(background_image, 0, 0, 0, WINDOW_WIDTH/background_image:getWidth(), WINDOW_HEIGHT/background_image:getHeight())
  -- if instructions_timer ~= nil then
  --   love.graphics.print(instructions_timer/love.timer.getFPS(), 10, 10)
  -- end
  
    
    --love.graphics.print(tostring(love.timer.getFPS()), 100, 100)
    if gamestate == "main_menu" then
        draw_main_menu()
    elseif gamestate == "play" then
        draw_townhall()
        --my addition archies
        Player_Draw()
        Bullet_Draw()
        enemyDraw()
        draw_enemy_bullet()
    elseif gamestate == 'gameover' then
      love.graphics.setColor(1, 1, 1)
      --love.graphics.print("RIP Keep 2 min silence for our fallen soldier ", WINDOW_WIDTH/2 - 425, WINDOW_HEIGHT/2 - 50)
      --love.graphics.print("game over sharam kar aur so ja", WINDOW_WIDTH/2 - 330, WINDOW_HEIGHT/2)
      --love.graphics.print("game over", WINDOW_WIDTH/2 - 425, WINDOW_HEIGHT/2 - 50)
      love.graphics.draw(gameover_image, WINDOW_WIDTH/2 - 488/2, WINDOW_HEIGHT/2 - 253/2 - 200)
      love.graphics.draw(main_menu_image, WINDOW_WIDTH/2 - 400/2, WINDOW_HEIGHT/2 + 100 - 200, 0, 400/main_menu_image:getWidth(), 100/main_menu_image:getHeight())
    elseif gamestate == "winner" then
      love.graphics.setColor(1, 1 ,1)
      --love.graphics.print("ye dil maange more", WINDOW_WIDTH/2 - 250, WINDOW_HEIGHT/2)
      --love.graphics.print("you survived", WINDOW_WIDTH/2 - 250, WINDOW_HEIGHT/2)
      love.graphics.draw(winning_screen_image, WINDOW_WIDTH/2 - 318/2, WINDOW_HEIGHT/2 - 265/2 - 50)
      love.graphics.draw(main_menu_image, WINDOW_WIDTH/2 - 400/2, WINDOW_HEIGHT/2 + 100, 0, 400/main_menu_image:getWidth(), 100/main_menu_image:getHeight())
    elseif gamestate == 'instructions' then
      love.graphics.setFont(love.graphics.newFont(30))
      love.graphics.print(math.floor(8 - instructions_timer), WINDOW_WIDTH/2, 100)
      love.graphics.draw(instructions_image, WINDOW_WIDTH/2 - 600/2, WINDOW_HEIGHT/2 - 400/2, 0, 600/instructions_image:getWidth(), 400/instructions_image:getHeight())
    end
    --love.graphics.print(tostring(totalenemy),WINDOW_WIDTH/2 - 330, WINDOW_HEIGHT/2 )
    --love.graphics.print(gamestate, 300, 200)
    --love.graphics.print(tostring(max_enemy), 400, 50)
    push:finish()
end
