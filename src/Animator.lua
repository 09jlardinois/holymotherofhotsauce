Animator = Class{}

gAnimationSets = {}

function Animator:init(atlasfile, x, y, stringatlasfriendlyname, totalanimationstates, numberofframesperstate, booleanstatictilesize)

    atlasfile:setWrap('clampzero', 'clampzero')

    -- Define the Animator's operation mode. Either static tile size or variable.
    if booleanstatictilesize ~= false then
      self.isTileSizeStatic = true
    else
      self.isTileSizeStatic = false
    end
    
    self.x = x
    self.y = y
    self.dX = 0
    self.dY = 0
    self.storeX = self.x
    self.storeY = self.y
        
    -- Define the total animation states (walking left, walking right, up down, etc.)
    -- And then the total frames per state.
    self.numAnimationStates = totalanimationstates or 1
    self.numAnimationFrames = numberofframesperstate or 2
    
    -- Assign the actual atlas file and give it a programmer-friendly name.
    self.atlasname = stringatlasfriendlyname or removeFileExtension(atlasfile, 'animation')
    
    -- Generates Quads specific to the animation sprite arrangement.
    generateAnimationQuads(atlasfile, self.atlasname, self.numAnimationStates, self.numAnimationFrames)
    
    -- The Frame index value
    self.frameroulette = 2
    -- Used for changing the current Frame.
    self.animationframe = 2
    -- Used for changing the current animation state.
    self.animationstate = 1
    -- The Frame "Rate"
    self.animationTicker = ANIMATION_TICKER
    -- The Frame rate timer. Stores deltatime.
    self.animationCounter = 0
    
    self.animationQuadIndex = self.animationstate + 3 * (self.animationframe - 1)
    
    self.runAnimation = false
    
end

function generateAnimationQuads(atlasfile, atlasfriendlyname, states, frames)

    spriteWidthDivider = math.floor(atlasfile:getWidth() / frames)
    spriteHeightDivider = math.floor(atlasfile:getHeight() / states)
        
    animationQuadArray = generateQuads(atlasfile, spriteWidthDivider, spriteHeightDivider)
    animationSetValues = {['atlasfile']=atlasfile, ['atlasarray']=animationQuadArray, ['width']=spriteWidthDivider, ['height']=spriteHeightDivider}
    
    gAnimationSets[atlasfriendlyname] = animationSetValues
    
end

function Animator:update(dt)

    -- Movement Detector
    self.dX = self.x - self.storeX
    self.dY = self.y - self.storeY
    local dV = self.dX * self.dX + self.dY * self.dY or 0
    
    -- Sprite Animation Cycle Section --
    -- NOTE: This cycle assumes a sprite sheet with 3 animation frames, left, center, right; where center frame is the starting & default frame.
    -- The frame cycle goes, center, left, center, right. It oscillates.
    -- This is designed to work with RPG Maker VX Ace format characters made with Game Character Hub in 3 x 4 format. So, a walking character.
    
    if dV ~= 0 then
    
    -- This is the animation timer.
    if self.animationCounter >= self.animationTicker then
        
        -- Changes the Sprite Index based on Frame Index.
        -- Must happen at top.

        if self.frameroulette == 1 or self.frameroulette == 3 then
            self.animationframe = 2
        elseif self.frameroulette == 2 then
            self.animationframe = 3
        elseif self.frameroulette == 4 then
            self.animationframe = 1
        end

        -- Advances the Frame Index based on Timer.
        if self.frameroulette < self.numAnimationFrames + 1 then
            self.frameroulette = self.frameroulette + 1
        else
            self.frameroulette = 1
        end
 
        -- Takes any ticker overshoot and adds it back to the next tick cycle. - Perfect timing, no waste.
        self.animationCounter = (self.animationCounter % self.animationTicker) * self.animationTicker
            
    end
    
    end
    
    self.animationQuadIndex = self.animationframe + 3 * (self.animationstate - 1)
    
    -- Advances the tick timer.
    self.animationCounter = self.animationCounter + dt
    
    self.storeX = self.x
    self.storeY = self.y
    -- Sprite Animation Cycle Section END --

end

function Animator:render()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(gAnimationSets[self.atlasname]['atlasfile'], animationQuadArray[self.animationQuadIndex], self.x, self.y)   

end