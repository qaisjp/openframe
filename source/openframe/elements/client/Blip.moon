-- Incomplete. Two constructors?
-- createBlip and createBlipAttachedTo
export Blip

class Blip extends Element
	element = nil

	new: (...) =>
		arg_count = #{...} 

		if arg_count => 3
			-- createBlip
			@element = createBlip ...
		else
			-- createBlipAttachedTo
			arguments = {...}
			arguments[1] = arguments[1]['element']
			@element = createBlipAttachedTo unpack(arguments)

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
