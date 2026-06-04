local mwn = {}

function mwn.toTable(name)
  local t = {}
  local currsec = nil
  local nests = {}
  local nestn = {}
  local nesta = #nests
  for lineu in love.filesystem.lines(name) do
    local line = "hello"
    local firstchar = string.sub(line,1,1)
    local lastchar = string.sub(line,-1,-1)
    if not currsec then
      --[[
        make the section be the name if starts w # and ends w " {"
      --]]
    else
      --[[
        many things very code
      --]]
    end
  end
end

return mwn