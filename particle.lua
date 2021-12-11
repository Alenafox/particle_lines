ParticlePart = {}
ParticlePart.__index = ParticlePart

function ParticlePart:create(locationA, locationB, lifespan)
    local particlePart = {}
    setmetatable(particlePart, ParticlePart)
    particlePart.locationA = locationA
    particlePart.locationB = locationB
    particlePart.clicked = False
    particlePart.lifespan = 80
    particlePart.decay = 0
    particlePart.acceleration = Vector:create(0, 0)
    particlePart.velocity = Vector:create(0, 0)
    return particlePart
end

function ParticlePart:draw()
    r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(1,1,1, self.lifespan / 100)
    if (self.clicked) then
        love.graphics.setColor(255,0,0, self.lifespan / 100)
    end
    love.graphics.line(self.locationA.x, self.locationA.y, self.locationB.x, self.locationB.y)
    love.graphics.setColor(r, g, b, a)
end

function ParticlePart:update()
    self.velocity:add(self.acceleration)
    self.locationA:add(self.velocity)
    self.locationB:add(self.velocity)
    self.acceleration:mul(0)
    self.lifespan = self.lifespan - self.decay
end

function ParticlePart:isDead()
    return self.lifespan > 0
end




Particle = {}
Particle.__index = Particle

function Particle:create(location)
    local particle = {}
    setmetatable(particle, Particle)
    particle.location = location
    particle.acceleration = Vector:create(0, 0)
    particle.velocity = Vector:create(0, 0)
    local locationB, locationC, locationD
    locationB = location:copy()
    locationB.x = locationB.x + 30
    locationC = locationB:copy()
    particle.particleTop = ParticlePart:create(location:copy(), locationB:copy())
    locationC.y = locationB.y + 30
    particle.particleLeft = ParticlePart:create(locationB:copy(), locationC:copy())
    locationD = locationC:copy()
    locationD.x = locationD.x - 30
    particle.particleBottom = ParticlePart:create(locationC:copy(), locationD:copy())
    particle.particleRight = ParticlePart:create(locationD:copy(), location:copy())
    return particle
end

function Particle:update()
    if self.particleTop then
        self.particleTop:update()
    end
    if self.particleTop then
        self.particleLeft:update()
    end
    if self.particleTop then
        self.particleBottom:update()
    end
    if self.particleTop then
        self.particleRight:update()
    end
end

function Particle:applyForce(force)
    self.acceleration:add(force)
end

function Particle:isDead()
    return self.particleTop:isDead() or self.particleBottom:isDead() or
            self.particleLeft:isDead() or self.particleRight:isDead()
end

function Particle:startDecay()
    print('clicked')
    self.particleTop.velocity = Vector:create(-10, 0)
    self.particleLeft.velocity = Vector:create(0, -10)
    self.particleBottom.velocity = Vector:create(10, 0)
    self.particleRight.velocity = Vector:create(0, 10)

    self.particleTop.decay = 6
    self.particleLeft.decay = 6
    self.particleBottom.decay = 6
    self.particleRight.decay = 6

    self.particleTop.clicked = true
    self.particleLeft.clicked = true
    self.particleBottom.clicked = true
    self.particleRight.clicked = true
end

function Particle:draw()
    r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(1, 1, 1, 1)
    self.particleTop:draw()
    self.particleLeft:draw()
    self.particleBottom:draw()
    self.particleRight:draw()
    love.graphics.setColor(r, g, b, a)
end

ParticleSystem = {}
ParticleSystem.__index = ParticleSystem

function ParticleSystem:create(origin, n, cls)
    local system = {}
    setmetatable(system, ParticleSystem)
    system.origin = origin
    system.n = n or 100
    system.cls = cls or Particle
    system.particles = {}
    system.index = 1
    system.isPressed = false
    return system
end

function ParticleSystem:draw()
	for k, v in pairs(self.particles) do
        self.particles[k]:draw()
    end
end

function ParticleSystem:update()
    if self.isPressed then
        if #self.particles < self.n then
           self.particles[self.index] = self.cls:create(self.origin:copy())
           self.index = self.index + 1
        end
    end
end

function ParticleSystem:applyForce(force)
    for k,v in pairs(self.particles) do
        v:applyForce(force)
    end
end
