function quitIfNoFuel()
	if turtle.getFuelLevel() == 0 then
		error('Out of fuel.')
	end
end

function countItem(name)
	total = 0
	for slot = 1, 16 do
		itemDetail = turtle.getItemDetail(slot)
		if itemDetail ~= nil then
			if itemDetail['name'] == name then
				total = total + itemDetail['count']
			end
		end
	end
	return total
end

function selectItem(name)
	for slot = 1, 16 do
		itemDetail = turtle.getItemDetail(slot)
		if itemDetail ~= nil then
			if itemDetail['name'] == name then
				turtle.select(slot)
				return true
			end
		end
	end
	return false
end



cmdArgs = {...}

LENGTH = tonumber(cmdArgs[1])
HEIGHT = tonumber(cmdArgs[2])
if cmdArgs[2] == nil then
	print('Usage: buildwall <length> <height>')
	return
end

numStoneBrick = countItem('minecraft:stonebrick')
if LENGTH * HEIGHT > numStoneBrick then
	print('You have ' .. numStoneBrick .. ' bricks.')
	print('You need ' .. (LENGTH * HEIGHT) .. ' to build this wall.')
	return
end


quitIfNoFuel()
turtle.up()
for curHeight = 1, HEIGHT do
	for curLength = 1, LENGTH do
		quitIfNoFuel()
		selectItem('minecraft:stonebrick')
		if turtle.placeDown() == false then
			error('Could not place blocks')
		end

		if curLength ~= LENGTH then
			if curHeight % 2 == 0 then
				turtle.back()
			else
				turtle.forward()
			end
		end
	end

	if curHeight ~= HEIGHT then
		turtle.up()
	end
end