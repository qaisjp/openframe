class Weapon extends Element
    new: (type, x, y, z) =>
        @element = createWeapon type, x, y, z
            
    fire: => fireWeapon @element
    reset_firing_rate: => resetWeaponFiringRate @element
    enable_effect: (name, enabled) => setSoundEffectEnabled name, enabled
    
    property: (id, skill, property, value) =>
        if value
            return setWeaponProperty @element, id, skill, property, value
        return getWeaponProperty @element, id, skill, property

    target: (target, component) =>
        if target and component
            return setWeaponTarget @element, target, component
        return getWeaponTarget @element

    state: (state) =>
        if state
            return setWeaponState @element, state
        return getWeaponState @element

    owner: (owner) =>
        if owner
            return setWeaponOwner @element, owner
        return getWeaponOwner @element

    flags: (flag, value) =>
        if flag and value
            return setWeaponFlags @element, flag, value
        return getWeaponFlags @element, flag

    firing_rate: (rate) =>
        if rate
            return setWeaponFiringRate @element, rate
        return getWeaponFiringRate @element

    clip_ammo: (clip_ammo) =>
        if clip_ammo
            return setWeaponClipAmmo @element, clip_ammo
        return getWeaponClipAmmo @element

    ammo: (ammo) =>
        if ammo
            return setWeaponpAmmo @element, ammo
        return getWeaponAmmo @element