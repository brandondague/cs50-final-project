StartState = Class{__includes = BaseState}

function StartState:init() 
    self.players = 1
    self.player1 = Paddle(10, 30, 5, 20)
    self.player2 = Paddle(VIRTUAL_WIDTH - 15, VIRTUAL_HEIGHT - 30, 5, 20)
    self.ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)
    self.servingPlayer = 1
    self.player1Score = 0
    self.player2Score = 0
end

function StartState:update(dt)
    if love.keyboard.wasPressed('right') then
        self.players = 2
        sounds['player_select']:play()
    elseif love.keyboard.wasPressed('left') then
        self.players = 1
        sounds['player_select']:play()
    elseif love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        sounds['start_game']:play()
        gStateMachine:change('serve', {
            players = self.players,
            player1 = self.player1,
            player2 = self.player2,
            ball = self.ball,
            servingPlayer = self.servingPlayer,
            player1Score = self.player1Score,
            player2Score = self.player2Score
        })
    end
end

function StartState:render() 
    love.graphics.setFont(largeFont)
    love.graphics.printf('Welcome to Pong!', 0, 10, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Select the number of players.', 0, 30, VIRTUAL_WIDTH, 'center')
    if self.players == 1 then
        love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 95, VIRTUAL_HEIGHT / 2 - 8, 80, 30)
        love.graphics.printf({{40/255, 45/255, 52/255, 255/255}, '1-PLAYER'}, VIRTUAL_WIDTH / 2 - 90, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH)
        love.graphics.printf('2-PLAYER', VIRTUAL_WIDTH / 2 + 20, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH)
    else
        love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 + 16, VIRTUAL_HEIGHT / 2 - 8, 80, 30)
        love.graphics.printf('1-PLAYER', VIRTUAL_WIDTH / 2 - 90, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH)
        love.graphics.printf({{40/255, 45/255, 52/255, 255/255}, '2-PLAYER'}, VIRTUAL_WIDTH / 2 + 20, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH)
    end
end