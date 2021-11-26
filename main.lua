require ("vector")
require ("particle")

function love.load()
   width = love.graphics.getWidth()
   height = love.graphics.getHeight()

   particles = {}
   systems = {}

	j = math.random(10, 15);

	for i = 1, j do
		x = math.random(50, width-100)
		y = math.random(50, height-100)
		particles[i] = Particle:create(Vector:create(x, y), 50)
		systems[i] = ParticleSystem:create(Vector:create(x, y), 50)
	end
end

function love.update(dt)
   x = math.random(50, width-100)
	y = math.random(50, height-100)
   for k,v in pairs(particles) do
		table.remove(v) 
      --table.insert(particles, Particle:create(Vector:create(x, y), 50)) 
	end
end

function love.draw()
   for k, v in pairs(particles) do
		v:draw()
	end
end

function love.mousepressed(x, y, button, istouch)
   if button == 1 then 
      for k,v in pairs(particles) do
         if math.abs(particles[k].location.x - x) < 15 and math.abs(particles[k].location.y - y) < 15 then
            systems[k].isPressed = true
            particles[k].location.x = -50
            particles[k].location.y = -50
         end
      end
   end
end
