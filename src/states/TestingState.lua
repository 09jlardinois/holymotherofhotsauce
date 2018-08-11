TestingState = Class{__includes = BaseState}


function TestingState:init()

 self.irishman = Character()

end
function TestingState:enter()



end
function TestingState:exit()



end
function TestingState:update(dt)

	if love.keyboard.wasPressed('return') then
		gStateMachine:change('start')
	end

	self.irishman:update(dt)

end
function TestingState:render()
	
	self.irishman:render()
	
	love.graphics.setFont(gFonts['small'])
	local msgFont = gFonts['small']
	
	local msgHite = 8
	local fontSize = msgFont.getHeight(gFonts['small'])
	local buffer = fontSize / 4
	love.graphics.setColor(0.8, 0.8, 0.4, 0.86)	
	love.graphics.printf(
	"Press ENTER to switch to Start State",
	0, msgHite, VIRTUAL_WIDTH, 'center')
	
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.printf(
	"Move character with w/a/s/d.",
	0, msgHite + fontSize + buffer, VIRTUAL_WIDTH, 'center')
	
end
