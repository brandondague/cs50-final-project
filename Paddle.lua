Paddle = Class{}


function Paddle:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = 0
end

function Paddle:update(dt)
    -- ensures paddle doesn't go beyond top bounds of screen
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    -- ensures paddle doesn't go beyond bottom bounds of screen
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
    end
end

function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end