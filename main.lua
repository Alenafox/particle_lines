require ("vector")
require ("particle")

function love.load()
   width = love.graphics.getWidth()
   height = love.graphics.getHeight()

   --particle = Particle:create(Vector:create(width/2, height/2))
   system = ParticleSystem:create(Vector:create(width/2, height/2), 1)
   gravity = Vector:create(0, 0.1)
end

function love.update(dt)
   -- particle:update()
   --system:applyForce(gravity)
   system:update()
end

function love.draw()
   -- particle:draw()
   system:draw()
end
