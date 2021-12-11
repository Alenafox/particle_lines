require ("vector")
require ("particle")

function love.load()
   width = love.graphics.getWidth()
   height = love.graphics.getHeight()

   particles = {}
   system = {}

	j = math.random(10, 15);

	for i = 1, j do
		x = math.random(50, width-100)
		y = math.random(50, height-100)
		particles[i] = Particle:create(Vector:create(x, y), 50)
	end
end

function love.update(dt)
   for k,v in pairs(particles) do
       particles[k]:update()
       if not particles[k]:isDead() then
           particles[k] = Particle:create(Vector:create(
                   math.random(50, width-100),
                   math.random(50, height-100)),
                   50
           )
       end
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
         if math.abs(particles[k].location.x - x) < 30 and math.abs(particles[k].location.y - y) < 30 then
            --system[k].isPressed = true
            particles[k]:startDecay()
         end
      end
   end
end
