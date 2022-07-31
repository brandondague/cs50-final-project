ServeState = Class{__includes = BaseState}

function ServeState:enter(params) 
    self.players = params.players
    self.player1 = params.player1
    self.player2 = params.player2
    self.ball = params.ball
    self.servingPlayer = params.servingPlayer
    self.player1Score = params.player1Score
    self.player2Score = params.player2Score
end

function ServeState:update(dt)
    self.ball.dy = math.random(-50, 50)
    if self.servingPlayer == 1 then
        self.ball.dx = math.random(140, 200)
    else
        self.ball.dx = -math.random(140, 200)
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play', {
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

function ServeState:render() 
    love.graphics.setFont(smallFont)
    love.graphics.printf('Player ' .. tostring(self.servingPlayer) .. "'s serve!", 
        0, 10, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter to serve!', 0, 20, VIRTUAL_WIDTH, 'center')

    self.player1:render()
    self.player2:render()
    self.ball:render()

    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(self.player1Score), VIRTUAL_WIDTH / 2 - 50,
        VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(self.player2Score), VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 3)
end