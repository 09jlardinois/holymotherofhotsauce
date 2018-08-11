function removeFileExtension(filename, mode)

	mode = mode or 'default'

	-- Prepare the string.
	-- Make it backwards so you only iterate up to the FIRST period to preserve file name if some dummy puts a period in it.
	filename = tostring(filename)
	filename = filename:reverse()

	-- Find the start of the extension.
	index, dud  = string.find(filename, '%.')

	-- Remove the extension.
	filename = string.sub(filename, index + 1)

	-- Return the filename to normal.
	filename = filename:reverse()

	-- Capitalizes first letter of original filename
	filename = capitalizeMe(filename)

	-- Adds mode-dependent prefixes.
	-- Use an auto-gen table for this.
	filename = gPrefixModes[mode] .. "_" .. filename


	return filename

end

function capitalizeMe(targetstring)

	firstletter = string.upper(string.sub(targetstring,1,1))
	alltherestoftheletters = string.sub(targetstring,2)
	return firstletter .. alltherestoftheletters

end
