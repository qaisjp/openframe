class Water extends Element
    new: (x1, y1, z1, x2, y2, z2, x3, y3, z3, x4, y4, z4, bShallow) =>
         @element = createWater x1, y1, z1, x2, y2, z2, x3, y3, z3, x4, y4, z4, bShallow
    
    vertex_position: (vertexIndex, x, y, z) =>
        if vertexIndex and x and y and z
            return setWaterVertexPosition @element, vertexIndex, x, y, z
        return getWaterVertexPosition @element vertexIndex