PlayState = Class{__includes = BaseState}

PADDLE_SPEED = 200

function PlayState:init()
    self.winningPlayer = 0
end

function PlayState:enter(params)
    self.players = params.players
    self.player1 = params.player1
    self.player2 = params.player2
    self.ball = params.ball
    self.servingPlayer = params.servingPlayer
    self.player1Score = params.player1Score
    self.player2Score = params.player2Score
end

function PlayState:update(dt)
    if self.ball:collides(self.player1) then
        self.ball.dx = -self.ball.dx * 1.03
        self.ball.x = self.player1.x + 5

        -- keep velocity going in the same direction, but randomize it
        if self.ball.dy < 0 then
            self.ball.dy = -math.random(10, 150)
        else
            self.ball.dy = math.random(10, 150)
        end

        sounds['paddle_hit']:play()
    end

    if self.ball:collides(self.player2) then
        self.ball.dx = -self.ball.dx * 1.03
        self.ball.x = self.player2.x - 4

        -- keep velocity going in the same direction, but randomize it
        if self.ball.dy < 0 then
            self.ball.dy = -math.random(10, 150)
        else
            self.ball.dy = math.random(10, 150)
        end

        sounds['paddle_hit']:play()
    end

    -- detect upper and lower screen boundary collision, playing a sound
    -- effect and reversing dy if true
    if self.ball.y <= 0 then
        self.ball.y = 0
        self.ball.dy = -self.ball.dy
        sounds['wall_hit']:play()
    end

    -- -4 to account for the ball's size
    if self.ball.y >= VIRTUAL_HEIGHT - 4 then
        self.ball.y = VIRTUAL_HEIGHT - 4
        self.ball.dy = -self.ball.dy
        sounds['wall_hit']:play()
    end

    -- if ball reachs the left or right edge of the screen, go back to serve
    -- and update the score and serving player
    if self.ball.x < 0 then
        self.servingPlayer = 1
        self.player2Score = self.player2Score + 1
        sounds['score']:play()

        -- if score of 10, the game is over; set the
        -- state to done to show the victory message
        if self.player2Score == 10 then
            self.winningPlayer = 2
            gStateMachine:change('done', {
                winningPlayer = self.winningPlayer,
                player1Score = self.player1Score,
                player2Score = self.player2Score
            })
        else
            self.ball:reset()
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

    if self.ball.x > VIRTUAL_WIDTH then
        self.servingPlayer = 2
        self.player1Score = self.player1Score + 1
        sounds['score']:play()

        if self.player1Score == 10 then
            self.winningPlayer = 1
            gStateMachine:change('done', {
                winningPlayer = self.winningPlayer,
                player1Score = self.player1Score,
                player2Score = self.player2Score

            })
        else
            self.ball:reset()
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

    if love.keyboard.isDown('w') then
        self.player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        self.player1.dy = PADDLE_SPEED
    else
        self.player1.dy = 0
    end

    if self.players == 1 then
        if self.ball.dx > 0 and self.ball.x > VIRTUAL_WIDTH / 2 then
            if self.ball.y < (self.player2.y + self.player2.height / 2) then
                self.player2.dy = -PADDLE_SPEED
            elseif self.ball.y > (self.player2.y + self.player2.height / 2) then
                self.player2.dy = PADDLE_SPEED
            else
                self.player2.dy = 0
            end
        else
            self.player2.dy = 0
        end
    else
        if love.keyboard.isDown('up') then
            self.player2.dy = -PADDLE_SPEED
        elseif love.keyboard.isDown('down') then
            self.player2.dy = PADDLE_SPEED
        else
            self.player2.dy = 0
        end
    end

    if love.keyboard.wasPressed('p') then
        sounds['pause']:play()
        gStateMachine:change('pause', {
            players = self.players,
            player1 = self.player1,
            player2 = self.player2,
            ball = self.ball,
            servingPlayer = self.servingPlayer,
            player1Score = self.player1Score,
            player2Score = self.player2Score
        })
    end

    self.ball:update(dt)
    self.player1:update(dt)
    self.player2:update(dt)
end

function PlayState:render()
    self.player1:render()
    self.player2:render()
    self.ball:render()

    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(self.player1Score), VIRTUAL_WIDTH / 2 - 50,
        VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(self.player2Score), VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 3)
end