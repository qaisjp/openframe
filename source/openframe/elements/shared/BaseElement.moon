export BaseElement

class BaseElement
	new: (type, id) =>
        @element = createElement type, id

    -- Why one would need these in here, I will never know
    root: => getRootElement()
    elements_by_type: (type, root, streamed_in) => getElementsByType(@element, type, root, streamed_in)
    by_id: (id, index) => getElementByID(id, index)


    destroy: => destroyElement(@element)
    radius: => getElementRadius(@element)
    low_lod: => isElementLowLOD(@element)
    syncer: => isElementSyncer(@element)
    syncer: => isElementSyncer(@element)
    on_screen: => isElementOnScreen(@element)
    local: => isElementLocal(@element)
    attached: => isElementAttached(@element)
    colshape: => getElementColShape(@element)
    within_colshape: => isElementWithinColShape(@element, shape)
    type: => getElementType(@element)
    streamed_in: => isElementStreamedIn(@element)
    children: (type) => getElementChildren(@element, type)
    children_count: => getElementChildrenCount(@element)
    bounding_box: => getElementBoundingBox(@element)
    attached_to: => getElementAttachedTo(@element)
    attached_elements: => getElementAttachedElements(@element)
    attached_offsets: => getElementAttachedOffsets(@element)
    child: (index) => getElementChild(@element, index)

    distance_from_centre_of_mass_to_base_of_model: => getElementDistanceFromCentreOfMassToBaseOfModel(@element)
    dfcomtbom: => getElementDistanceFromCentreOfMassToBaseOfModel(@element)

    attach: (ele, xp, yp, zp, xr, yr, zr) => attachElements(@element, ele, xp, yp, zp, xr, yr, zr)
    detach: (ele) => detachElements

    position: (x, y, z, warp) =>
        if x and y and z
            return setElementPosition @element, x, y, z, warp
        return getElementPosition @element

    rotation: (x, y, z, rotOrder, conform) =>
        if x and y and z
            return setElementRotation @element, x, y, z, rotOrder, conform
        return getElementRotation @element, x -- x, in this case is rotOrder

    alpha: (alpha) =>
        if alpha
            return setElementAlpha @element, alpha
        return getElementAlpha @element

    dimension: (dim) =>
        if dim
            return setElementDimension @element, dim
        return getElementDimension @element

    health: (amount) =>
        if amount
            return setElementHealth @element, amount
        return getElementHealth @element

    velocity: (x, y, z) =>
        if x and y and z
            return setElementVelocity @element, x, y, z
        return getElementVelocity @element

    double_sided: (state) =>
        if state
            return setElementDoubleSided @element, state
        return getElementDoubleSided @element

	collidable_with: (ele, enabled) =>
        if enabled
            return setElementCollidableWidth @element, ele, enabled
        return isElementCollidableWidth @element ele

    model: (id) =>
        if id
            return setElementModel @element, id
        return getElementModel @element

    interior: (interior) =>
        if interior
            return setElementInterior @element, interior
        return getElementInterior @element

    streamable: (state) =>
        if state
            return setElementStreamable @element, state
        return getElementStreamable @element

    collisions_enabled: (enabled) =>
        if enabled
            return setElementCollisionsEnabled @element, enabled
        return getElementCollisionsEnabled @element

    data: (k, v, sync) =>
        if k and v
            return setElementData @element, k, v, sync
        return getElementData @element, k, v -- v, in this case is "inherit"

    low_lod_element: (ele) =>
        if ele
            return setLowLODElement @element, ele
        return getLowLODElement @element

    id: (id) =>
        if id
            return setElementID @element, id
        return getElementID @element

	parent: (parent) =>
        if parent
            return setElementParent @element, parent
        return getElementParent @element

    frozen: (state) =>
        if state
            return setElementFrozen @element, state
        return isElementFrozen @element

    -- Disabled because get and set both have 1arg
    --matrix: (matrix_legacy) =>
    --    if enabled
    --        return setElementMatrix @element, matrix
    --    return getElementMatrix @element, legacy