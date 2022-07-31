PauseState = Class{__includes = BaseState}

function PauseState:enter(params)
    self.players = params.players
    self.player1 = params.player1
    self.player2 = params.player2
    self.ball = params.ball
    self.servingPlayer = params.servingPlayer
    self.player1Score = params.player1Score
    self.player2Score = params.player2Score
end

function PauseState:update(dt)
    if love.keyboard.wasPressed('p') then
        sounds['unpause']:play()
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

function PauseState:render()
    self.player1:render()
    self.player2:render()
    self.ball:render()

    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(self.player1Score), VIRTUAL_WIDTH / 2 - 50,
        VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(self.player2Score), VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 3)
    love.graphics.setFont(largeFont)
    love.graphics.printf('Paused', 0, 10, VIRTUAL_WIDTH, 'center')
end