local mwn = {}

function mwn.toTable(name, retcomm)
  local t = {}
  local currlinen = 0
  local currsec = nil
  local nests = {}
  nests[0] = "section"
  local nestn = {}
  nestn[0] = "A section"
  local nesta = #nests
  local comments = {}
  for lineu in love.filesystem.lines(name) do
    currlinen = currlinen + 1
    local line = string.gsub(lineu, "^%s+", "")
    local firstchar = string.sub(line,1,1)
    local secndchar = string.sub(line,2,2)
    local lastchar = string.sub(line,-1,-1)
    local middlechars = string.sub(line,2,-3)
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
        local current = t[currsec]
        for _,v in ipairs(nestn) do
          current = current[v]
        end
        current[middlechars] = current[middlechars] or {__type = "list"}
        nesta = nesta+1
        table.insert(nestn,middlechars)
        table.insert(nests,"list")
      elseif firstchar == "$" then
        local current = t[currsec]
        for _,v in ipairs(nestn) do
          current = current[v]
        end
        current[middlechars] = current[middlechars] or {__type = "list"}
        nesta = nesta+1
        table.insert(nestn,middlechars)
        table.insert(nests,"array")
      elseif (firstchar == "/") and (secndchar == "/") then
        table.insert(comments, string.sub(middlechars,2,-1))
      else
        local current = t[currsec]
        for _,v in ipairs(nestn) do
          current = current[v]
        end
        if nests[nesta] ~= "array" then
          local index, value = line:match("(.-) (.*)")
          if not (index or value) then
            error("placeholder")
          end
          current[index] = value
        else
          table.insert(current, line)
        end
      end
    end
  end
  if retcomm then
    return t, comments
  end
  return t
end

local function tmlist(index, t)
  local mStr = "*" .. index .. " [\n"
  for i, v in pairs(t) do
    if type(v) == "function" then
      error("hi")
    elseif type(v) == "table" then
      if w.__type == "array" then
        mStr = mStr .. tmarr(i, v)
      else
        mStr = mStr .. tmlist(i, v)
      end
    elseif type(v) == "nil" then
      mStr = mStr .. i .. " NULL\n"
    else
      mStr = mStr .. i .. " " .. v .. "\n"
    end
  end
  mStr = mStr .. "]\n"
  return mStr
end

local function tmarr(index, t)
  --[[
  on second thought i wont delete em but i will make some changes
  --]]
end

function mwn.toMeowin(t)
  local mStr = ""
  for i, v in pairs(t) do
    if type(v) ~= "table" then
      error(i .. " is not a table")
    end
    mStr = mStr .. "#" .. i .. " {\n"
    for k, w in pairs(v) do
      if type(w) == "function" then
        print("idk bro functions are not allowe$")
        error("type FUNCTION is not allowed in regular Meowin'")
      elseif type(w) == "table" then
        if w.__type == "array" then
          mStr = mStr .. tmarr(k, w)
        else
          mStr = mStr .. tmlist(k, w)
        end
      elseif type(w) == "nil" then
        mStr = mStr .. i .. " NULL\n"
      else
        mStr = mStr .. i .. " " .. w .. "\n"
      end
    end
    mStr = mStr .. "}\n\n"
  end
end

return mwn