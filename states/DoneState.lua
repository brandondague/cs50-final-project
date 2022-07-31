DoneState = Class{__includes = BaseState}

function DoneState:enter(params)
    self.winningPlayer = params.winningPlayer
    self.player1Score = params.player1Score
    self.player2Score = params.player2Score
end

function DoneState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('start')
    end
end

function DoneState:render()
    love.graphics.setFont(largeFont)
    love.graphics.printf('Player ' .. tostring(self.winningPlayer) .. ' wins!',
        0, 10, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(smallFont)
    love.graphics.printf('Press Enter to restart!', 0, 30, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(self.player1Score), VIRTUAL_WIDTH / 2 - 50,
        VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(self.player2Score), VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 3)
end