local mwn = {}

function mwn.toTable(name)
  local t = {}
  local currlinen = 0
  local currsec = nil
  local nests = {}
  nests[0] = "section"
  local nestn = {}
  local nesta = #nests
  for lineu in love.filesystem.lines(name) do
    currlinen = currlinen + 1
    local line = string.gsub(lineu, "^%s+", "")
    local firstchar = string.sub(line,1,1)
    local secndchar = string.sub(line,2,2)
    local lastchar = string.sub(line,-1,-1)
    if not currsec then
      if firstchar == "#" then
        currsec = line:sub(2,-3)
        t[currsec] = t[currsec] or {}
      end
    else
      if firstchar == "}" then
        if nesta == 0 then
          currsec = nil
        else
          error("Meowin' file " .. name .. ", line " .. currlinen .. ": Did not close other " .. nesta .. " lists/arrays before closing section")
        end
      elseif firstchar == "]" then
        if nests[nesta] == "list" then
          nests[nesta] = nil
          nestn[nesta] = nil
          nesta = nesta-1
        else
          error("Meowin' file " .. name .. ", line " .. currlinen .. ": " .. nestn[nesta] .. "is not a list")
        end
      elseif firstchar == ")" then
        if nests[nesta] == "array" then
          nests[nesta] = nil
          nestn[nesta] = nil
          nesta = nesta-1
        else
          error("Meowin' file " .. name .. ", line " .. currlinen .. ": " .. nestn[nesta] .. "is not an array")
        end
      elseif firstchar == "*" then
      elseif firstchar == "$" then
      elseif (firstchar == "/") and (secndchar == "/") then
      else
      end
      --[[
        okay so basically do:
        if its a regular value put it as normal index
        if its starts with * or $ do a list or numbered list
        if its ] or } or ) end the current
        if its // ignore it
        thats it
      --]]
    end
  end
end

return mwn