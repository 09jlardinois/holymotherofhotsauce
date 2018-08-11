--[[

    GD50 2018

    Breakout Remake



    -- constants --



    Author: Colton Ogden

    cogden@cs50.harvard.edu



    Some global constants for our application.

]]

-- size of our actual window
WINDOW_WIDTH, WINDOW_HEIGHT = love.window.getDesktopDimensions()

-- size we're trying to emulate with push
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

gPrefixModes = {
	['animation'] = 'anim',
	['image'] = 'img'
}

ANIMATION_TICKER = 0.5

PADDLE_SPEED = 30
