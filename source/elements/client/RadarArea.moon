class RadarArea extends Element
    new: (lx, by, sx, sy, r, g, b, a) =>
        @element = createRadarAreap(lx, by, sx, sy, r, g, b, a)
            
    inside: (x, y) => isInsideRadarArea(@element, x, y)
    amount: => getPickupAmmount @element
    weapon: => getPickupWeapon @element
    
    color: (r, g, b, a) =>
        if r and g and b and a
            return setRadarAreaColor @element, r, g, b, a
        return getRadarAreaColor @element

    flashing: (bool) =>
    	if bool
    		return setRadarAreaFlashing @element, bool
    	return isRadarAreaFlashing @element