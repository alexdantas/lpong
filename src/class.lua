-- class.lua: An easy way to implement classes in Lua
--
-- To create a class, say, Person:
--
--    require 'class'
--
--    Person = class()
--
--    function Person:init(name, age) -- constructor must have this name
--       self.name = name
--       self.age  = age
--    end
--
--    newPerson = Person("John Doe", 20)
--
-- Source: http://wiki.inspired-lua.org/class()

class = function(prototype)
   local derived = {}

   if prototype then
      function derived.__index(t, key)
         return rawget(derived, key) or prototype[key]
      end
   else
      function derived.__index(t, key)
         return rawget(derived, key)
      end
   end

   function derived.__call(proto, ...)
      local instance = {}
      setmetatable(instance, proto)
      local init = instance.init
      if init then
         init(instance, ...)
      end
      return instance
   end

   setmetatable(derived, derived)
   return derived
end

