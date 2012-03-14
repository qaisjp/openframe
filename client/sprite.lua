--push([[
Sprite = Class:Create()
function Sprite:Create(dir, container, fps, times)
  local sprite = Class:Create(Sprite)
  local imgs, fps, times = {...}, tonumber(fps), tonumber(times)
  if type(dir) == 'string' and fps then
    sprite.dir, sprite.fps = dir, fps
    if not times then
      if fileExists(dir..img) and times then
        sprite.img = container
        sprite.sprites = times
      else
        return false
      end
    else
      for _,v in ipairs(container) do
        if ( not (type(v) == 'string') ) or ( not fileExists(dir..v) ) then
          return false
        end
      end
      sprite.img = container
    end
    return sprite
  end
  return false
end

function Sprite:Draw(x, y, w, h, r,  rx,ry, color, post)
  if type(self.img) == 'string' then
    --[[for i=1, self.sprites do
      Screen:Image(x, y, w, h, self.dir..self.img:format(i).., r, rx, ry, color, postgui)
    end]]
    -- do some getTickCount() calcs regarding self.fps
  elseif type(self.img) == 'table' then
    --[[for i,v in ipairs(self.img) do
       Screen:Image(x, y, w, h, self.dir..self.img[i], r, rx, ry, color, postgui)
    end]]
    -- do some same calcs as above
  end
  return false
end

]])

