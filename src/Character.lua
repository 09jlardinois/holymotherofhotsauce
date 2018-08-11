Character = Class{}

function Character:init()

	-- Define the character's location.
	self.x = VIRTUAL_WIDTH / 2 - 16
	self.y = VIRTUAL_HEIGHT / 2

	-- Define the character's starting sprite index.
	-- Animations will be handled on a sprite sheet. You need to set the starting index.
	self.animationFrame = 2
	self.animationState = 1

	self.animatorName = 'character'
	self.animator = Animator(gTextures['character'], self.x, self.y, self.animatorName, 4, 3)

end

function Character:update(dt)

	self.animator:update(dt)

	if love.keyboard.isDown('w') then
		self.y = self.y - WALK_SPEED * dt
		self.animator.animationstate = 4
	end

	if love.keyboard.isDown('s') then
		self.y = self.y + WALK_SPEED * dt
		self.animator.animationstate = 1
	end

	if love.keyboard.isDown('d') then
		self.x = self.x + WALK_SPEED * dt
		self.animator.animationstate = 3
	end

	if love.keyboard.isDown('a') then
		self.x = self.x - WALK_SPEED * dt
		self.animator.animationstate = 2
	end

	self.animator.x = self.x
	self.animator.y = self.y


end

function Character:render()

	self.animator:render()

end
