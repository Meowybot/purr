local mwn = require("lib.meowin.mwn")

local mws = {}

function mws.toLua(name)
  local t
  if type(name) == "string" then
    t = mwn.toTable(name)
  elseif type(name) == "table" then
    t = name
  else
    error("place")
  end
end

return mws