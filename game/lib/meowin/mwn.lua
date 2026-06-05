local mwn = {}

function mwn.toTable(name)
  local t = {}
  local currsec = nil
  local nests = {}
  local nestn = {}
  local nesta = #nests
  for lineu in love.filesystem.lines(name) do
    local line = string.gsub(lineu, "^%s+", "")
    local firstchar = string.sub(line,1,1)
    local lastchar = string.sub(line,-1,-1)
    if not currsec then
      if firstchar == "#" then
        t[line:sub(2, -3)] = t[line:sub(2, -3)] or {}
      end
    else
      --[[
        okay so basically do:
        if its a regular value put it as normal index
        if its starts with * or $ do a list or numbered list
        thats it
      --]]
    end
  end
end

return mwn