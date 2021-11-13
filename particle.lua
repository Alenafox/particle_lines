Particle = {}
Particle.__index = Particle

function Particle:create(location)
	local particle = {}
	setmetatable(particle, Particle)
	particle.location = location
    particle.acceleration = Vector:create(0, 0.05)
    particle.velocity = Vector:create(math.random(-400, 400) / 100, math.random(-200, 0) / 100)
    particle.lifespan = 50
    particle.decay = math.random(3, 8) / 10
	return particle
end

function Particle:update()
    --self.velocity:add(self.acceleration)
    --self.location:add(self.velocity)
    --self.acceleration:mul(0)
    --self.lifespan = self.lifespan - self.decay
end

function Particle:applyForce(force)
    self.acceleration:add(force)
end

function Particle:isDead()
    return self.lifespan < 0
end

function Particle:draw()
    r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(1,1,1, self.lifespan / 100)
    love.graphics.rectangle("line", self.location.x + math.random(-400, 400) / 10, self.location.y + math.random(-400, 400) / 10, math.random(-400, 400) / 10, math.random(-400, 400) / 10)
    love.graphics.setColor(r,g,b,a)
end


ParticleSystem = {}
ParticleSystem.__index = ParticleSystem 

function ParticleSystem:create(origin, n, cls)
	local system = {}
	setmetatable(system, ParticleSystem)
	system.origin = origin
    system.n = n or 10
    system.cls = cls or Particle
    system.particles = {}
    system.index = 1
	return system
end

function ParticleSystem:applyForce(force)
    for k, v in pairs(self.particles) do
        v:applyForce(force)
    end
end

function ParticleSystem:draw()
   -- love.graphics.circle("line", self.origin.x, self.origin.y, 10)
    for k, v in pairs(self.particles) do
        v:draw()
    end
end

function ParticleSystem:update()
    if #self.particles < self.n then
        self.particles[self.index] = self.cls:create(self.origin:copy())
        --self.index = self.index + 1
    end
end
