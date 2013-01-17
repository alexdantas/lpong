-- pad.lua: stuff related to the player-controlled pad

require 'src.class'

Pad = class()

function Pad:init(x, y)
   x = x or 0
   y = y or 0

   self.x = x
   self.y = y
   self.speed  = 150
   self.width  = 125
   self.height = 10
   self.direction = {
      right = false,
      left  = false
   }
end

function Pad:draw()
   love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

-- Only moves Pad if direction_right or direction_left is set
-- and it's within the level's bounds
function Pad:move(dt)
   if (self.x + self.width) > max_play_x then
      self.x = max_play_x - self.width
      return false
   end
   if self.x < min_play_x then
      self.x =  min_play_x
      return false
   end

   if     self.direction.right then
      self.x = self.x + (self.speed * dt)
   elseif self.direction.left then
      self.x = self.x - (self.speed * dt)
   end

   return true
end

-- Prints itself completely on console for debugging purposes
function Pad:dump()
   print("x:      " ..self.x)
   print("y:      " ..self.y)
   print("speed:  " ..self.speed)
   print("width:  " ..self.width)
   print("height: " ..self.height)
end


