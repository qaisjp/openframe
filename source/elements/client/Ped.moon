class Ped extends Element
    new: (model, x, y, z, rot) =>
        @element = createPed model, x, y, z, rot

    choking: => isPedChoking(@element)
    ducked: => isPedDucked(@element)
    warp: (veh, seat) => warpPedIntoVehicle(@element, veh, seat)
    armor: => getPedArmor(@element)

    knocked_off_bike: (can) =>
        if can
            return setPedCanBeKnockedOffBike @element, can
        return canPedBeKnockedOffBike @element

    headless: (state) =>
        if state
            return setPedHeadless @element, state
        return setPedHeadless @element

    oxygen_level: (oxygen) =>
        if oxygen
            return setPedOxygenLevel @element, oxygen
        return getPedOxygenLevel @element

    animation: (block, anim, time, loop, update, interruptable, freeze) =>
        if block ~= nil
            return setPedAnimation @element, block, anim, time, loop, update, interruptable, freeze
        return getPedAnimatino @element