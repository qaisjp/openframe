class Pickup extends Element
    new: (x, y, z, type, var, respawn, ammo) =>
        @element = createPickup(x, y, z, type, var, respawn, ammo)
            
    ammo: => getPickupAmmo @element
    amount: => getPickupAmmount @element
    weapon: => getPickupWeapon @element
    
    type: (type, var, ammo) =>
        if type
            return setPickupType @element, type, var, ammo
        return getPickupType @element