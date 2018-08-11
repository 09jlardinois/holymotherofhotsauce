--[[
    GD50
    Breakout Remake

    -- StartState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Represents the state the game is in when we've just started; should
    simply display "Breakout" in large text, as well as a message to press
    Enter to begin.
]]

-- the "__includes" bit here means we're going to inherit all of the methods
-- that BaseState has, so it will have empty versions of all StateMachine methods
-- even if we don't override them ourselves; handy to avoid superfluous code!
StartState = Class{__includes = BaseState}

-- whether we're highlighting "Start" or "High Scores"
local highlighted = 1

function StartState:init()
  
  self.paddle = Paddle()
  self.characterBug = Bug()

end

function StartState:update(dt)
  -- toggle highlighted option if we press an arrow key up or down
  if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
    highlighted = highlighted == 1 and 2 or 1
    gSounds['paddle-hit']:play()
  end

  -- we no longer have this globally, so include here
  if love.keyboard.wasPressed('escape') then
    love.event.quit()
  end
  
  self.characterBug:update(dt)
  
  -- update positions based on velocity
  self.paddle:update(dt)
  
end

function StartState:render()
  self.paddle:render()

  -- title
  love.graphics.setFont(gFonts['large'])
  love.graphics.printf("BREAKOUT", 0, VIRTUAL_HEIGHT / 3,
    VIRTUAL_WIDTH, 'center')

  -- instructions
  love.graphics.setFont(gFonts['medium'])

  -- reset the color
  love.graphics.setColor(103/255, 1, 1, 0.45)

  -- if we're highlighting 1, render that option blue
  if highlighted == 1 then
    love.graphics.setColor(103/255, 1, 1, 1)
  end
  love.graphics.printf("START", 0, VIRTUAL_HEIGHT / 2 + 70,
    VIRTUAL_WIDTH, 'center')

  -- reset the color
  love.graphics.setColor(103/255, 1, 1, 0.45)

  -- render option 2 blue if we're highlighting that one
  if highlighted == 2 then
    love.graphics.setColor(103/255, 1, 1, 1)
  end
  love.graphics.printf("HIGH SCORES", 0, VIRTUAL_HEIGHT / 2 + 90,
    VIRTUAL_WIDTH, 'center')

  -- reset the color
  love.graphics.setColor(103/255, 1, 1, 0.65)
  
  self.characterBug:render()
  
end
