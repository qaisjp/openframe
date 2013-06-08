class Sound extends Element
    new: (path, looped, x, y, z) =>
        if not x or not y or not z
            @element = playSound path, looped
        else
            @element = playSound3D path, x, y, z, looped
            
    length: => getSoundLength @element
    effects: => setSoundEffects @effects
    meta_tags: => getSoundMetaTags @element
    enable_effect: (name, enabled) => setSoundEffectEnabled name, enabled
    stop: => stopSound @element
    bpm: => getSoundBPM @element
    fft: (samples, bands) => getSoundFFTData @element, samples, bands
    wave: (samples) => getSoundWaveData @element, samples
    level: => getSoundLevelData @element
    
    max_distance: (value) =>
        if value
            return setSoundMaxDistance @element, value
        return getSoundMaxDistance @element
    
    min_distance: (value) =>
        if value
            return setSoundMinDistance @element, value
        return getSoundMinDistance @element
        
    position: (value) =>
        if value
            return setSoundPosition @element, value
        return getSoundPosition @element
        
    speed: (value) =>
        if value
            return setSoundSpeed @element, value
        return getSoundSpeed @element
        
    volume: (value) =>
        if value
            return setSoundVolume @element, value
        return getSoundVolume @element

    paused: (value) =>
        if value
            return isSoundPaused @element
        return setSoundPaused @element, value
    
    properties: (srate, tempo, pitch, reverse) =>
        if srate and tempo and pitch and reverse
            return setSoundProperties @element, srate, tempo, pitch, reverse
        return getSoundProperties @element
    
    pan: (value) =>
        if value
            return setSoundPan @element, value
        return getSoundPan @element