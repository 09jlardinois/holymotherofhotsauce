function generateQuads(atlas, spritewidth, spriteheight)

	local tileIndexXCount = atlas:getWidth() / spritewidth
	local tileIndexYCount = atlas:getHeight() / spriteheight

	local spriteSheetIndex = 1
	spriteSheetArray = {}

	for y = 0, tileIndexYCount - 1 do

		for x = 0, tileIndexXCount - 1 do

			spriteSheetArray[spriteSheetIndex] =
				love.graphics.newQuad(x * spritewidth, y * spriteheight, spritewidth, spriteheight, atlas:getDimensions())

			spriteSheetIndex = spriteSheetIndex + 1
		end

	end

	return spriteSheetArray

end
