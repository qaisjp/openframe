class Sound extends Element
    new: (path, looped, x, y, z) =>
        if not x or not y or not z
            @element = playSound path, looped
        else
            @element = playSound3D path, x, y, z, looped
    destroy: => destroyElement @element