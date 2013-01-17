-- ball.lua: all stuff related to the bouncing ball

-- Defines a clean way to create classes in Lua.
require 'src.class'


Ball = class()

-- Creates a new ball. Watch out for the default values of x, y and r (radius)
function Ball:init(x, y, r)
   x = x or 0
   y = y or 0
   r = r or 5

   -- positioning and movement
   self.x      = x
   self.y      = y
   self.speed  = 100
   self.radius = r
   self.width  = r * 2
   self.height = r * 2
   self.direction_x = -1
   self.direction_y = -1

   -- flags for behaviour
   self.will_accelerate = false
   self.accel_rate      = 0
   self.is_dead         = false
end

-- If 'will_accelerate' is true, on each step from now on,
-- ball's speed will increase by 'ammount' (it can be negative)
function Ball:accelerate(will_accelerate, rate)
   rate = rate or 0

   self.will_accelerate = will_accelerate
   self.accel_rate      = rate
end

-- Keeps the ball's speed constant from now on
function Ball:reset_speed()
   self.speed = 100
end

-- Move the ball by one step. It requires dt to keep consistency between pcs
function Ball:move(dt)
   self.x = self.x + self.direction_x * (self.speed * dt)
   self.y = self.y + self.direction_y * (self.speed * dt)

   if self.will_accelerate then
      self.speed = self.speed + self.accel_rate * dt
   end
end

-- Test if the ball has reached the end of the screen and needs bouncing.
-- If it does, try to. Also flags if the ball has reached the 'game over' line
function Ball:bounce_if_out_of_bounds()
   local will_bounce_x = false
   local will_bounce_y = false

   if self.x >= max_play_x or self.x <= min_play_x  then
      will_bounce_x = true
   end
   if self.y <= min_play_y then
      will_bounce_y = true
   end
   if self.y >= max_play_y then
      self.is_dead  = true
   end

   self:bounce(will_bounce_x, will_bounce_y)
end

-- Changes the ball's direction on the x and y axis if respective
-- arguments are true
function Ball:bounce(bounce_x, bounce_y)
   if bounce_x then self.direction_x = (self.direction_x * -1) end
   if bounce_y then self.direction_y = (self.direction_y * -1) end
end

function Ball:draw()
   love.graphics.circle("fill", self.x, self.y, self.radius)
end

-- I assume the object has these properties:
--   x, y, width and height
function Ball:bounce_if_collided_with(object)
   if not (object.x and object.y and object.width and object.height) then
      return false
   end

   local ax = self.x + self.width
   local ay = self.y + self.height
   local bx = object.x + object.width
   local by = object.y + object.height
   local will_bounce_x = false
   local will_bounce_y = false

   -- collided on top or bototm of 'object'
   if self.x < bx and ax > object.x and ay > object.y and self.y < by then
      will_bounce_y = true

   -- collided on the left or right of 'object'
   elseif self.y < by and ay > object.y and ax < bx and ax > object.x then
      will_bounce_x = true
   end

   self:bounce(will_bounce_x, will_bounce_y)
   return true
end



-- It'd be nice to have a debug function
function Ball:debug()

end

-- Prints itself completely for debugging purposes
function Ball:dump()
   print("x:      " ..self.x)
   print("y:      " ..self.y)
   print("speed:  " ..self.speed)
   print("radius: " ..self.radius)
   print("direction_x:   " ..self.direction_x)
   print("direction_y:   " ..self.direction_y)
end

