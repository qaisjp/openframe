-- Incomplete. Two constructors?
-- createBlip and createBlipAttachedTo
export Blip

class Blip extends Element
	element = nil

	new: (...) =>
		arguments = {...}

		if argument[0]['element']
			-- createBlipAttachedTo
			arguments[0] = arguments[0]['element']
			@element = createBlipAttachedTo unpack(arguments)
		else
			-- createBlip
			@element = createBlip ...
			

	color: (color = nil) =>
		if color == nil
			getBlipColor @element
		else
			setBlipColor @element, color

	icon: (icon = nil) =>
		if icon == nil
			getBlipIcon @element
		else
			setBlipIcon @element, icon

	size: (size = nil) =>
		if size == nil
			getBlipSize @element
		else
			setBlipSize @element, size

	ordering: (order = nil) =>
		if order == nil
			getBlipOrdering @element
		else
			setBlipOrdering @element, order

	visible_distance: (distance = nil) =>
		if distance == nil
			getBlipVisibleDistance @element
		else
			setBlipVisibleDistance @element, distance
