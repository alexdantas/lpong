-- lpong - a simple pong game in lua with love
require 'src.ball'
require 'src.pad'

-- actual screen size
screen_width  = 600
screen_height = 500
-- but the game objects only act on this
min_play_x = 0
min_play_y = 0
max_play_x = screen_width
max_play_y = screen_height

function love.load()
   ball = Ball(max_play_x / 2, max_play_y / 2)
   player = Pad(max_play_x / 2, max_play_y - 50)
   player2 = Pad(max_play_x / 2, min_play_y + 50)
end

function love.update(dt)
   ball:move(dt)
   player:move(dt)
   player2:move(dt)
   ball:bounce_if_collided_with(player)
   ball:bounce_if_collided_with(player2)
   ball:bounce_if_out_of_bounds()
   if ball.is_dead then quit_game() end

end

function love.draw()
   ball:draw()
   player:draw()
   player2:draw()
end

function love.keypressed(key, unicode)
   if key == "q" then
      quit_game()
   elseif key == "right" then
      player.direction.right = true
   elseif key == "left" then
      player.direction.left = true
   elseif key == "d" then
      player2.direction.right = true
   elseif key == "a" then
      player2.direction.left = true

   -- Test keys for debugging purposes
   elseif key == "1" then
      ball:accelerate(false)
   elseif key == "2" then
      ball:accelerate(true, 100)
   elseif key == "3" then
      ball:reset_speed()
   end
end

function love.keyreleased(key, unicode)
   if     key == "right" then
      player.direction.right = false
   elseif key == "left" then
      player.direction.left = false
   elseif key == "d" then
      player2.direction.right = false
   elseif key == "a" then
      player2.direction.left = false
   end
end

-- This works around an issue on quitting between love versions.
function quit_game()
   local f = love.event.quit or love.event.push
   f('q')
end

