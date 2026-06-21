local mwn = require("lib.meowin.mwn")

local mws = {}

function mws.toLua(name, funcTrans, udft, cbTrans, udct)
  local luas = "local mwztr = {}\n"
  local luend = "return mwztr\n"
  local t
  if type(name) == "string" then
    t = mwn.toTable(name)
  elseif type(name) == "table" then
    t = name
  else
    error("place")
  end
  local dft = udft ~= false
  local dct = udct ~= false
  for i, v in pairs(t) do

    if cbTrans[i] then
    elseif dct[i] then
    end

  end
  luas = luas .. luend
end

return mws