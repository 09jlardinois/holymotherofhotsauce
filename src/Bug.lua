Bug = Class{}

function Bug:init()

	-- Define the bug's location.
	self.x = VIRTUAL_WIDTH / 2 - 16
	self.y = VIRTUAL_HEIGHT / 2

	-- Define the bug's starting sprite index.
	-- Animations will be handled on a sprite sheet. You need to set the starting index.
	self.animationFrame = 2
	self.animationState = 1

	self.animatorName = 'bug'
	self.animator = Animator(gTextures['buganimation'], self.x, self.y, self.animatorName, 4, 3)

end

speed = 30

function Bug:update(dt)

	self.animator:update(dt)

	if love.keyboard.isDown('w') then
		self.y = self.y - speed * dt
		self.animator.animationstate = 4
	end

	if love.keyboard.isDown('s') then
		self.y = self.y + speed * dt
		self.animator.animationstate = 1
	end

	if love.keyboard.isDown('d') then
		self.x = self.x + speed * dt
		self.animator.animationstate = 3
	end

	if love.keyboard.isDown('a') then
		self.x = self.x - speed * dt
		self.animator.animationstate = 2
	end

	self.animator.x = self.x
	self.animator.y = self.y


end

function Bug:render()

	self.animator:render()

end
