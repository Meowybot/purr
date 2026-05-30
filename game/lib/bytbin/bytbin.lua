local bit = require("bit")

local bytbin = {}

local Writer = {}
Writer.__index = Writer

function bytbin.newWriter()
    return setmetatable({ bytes = "", nibblePending = false, pendingNibble = 0 }, Writer)
end

function Writer:writeU8(v)
  self.bytes = self.bytes .. string.pack("B", v)
end

function Writer:writeU16(v)
  self.bytes = self.bytes .. string.pack("<H", v)
end

function Writer:writeFloat(v)
  self.bytes = self.bytes .. string.pack("f", v)
end

function Writer:writeString(s)
    self.bytes = self.bytes .. string.pack("s1", s)
end

function Writer:writeNibble(v)
  if not self.nibblePending then
    self.pendingNibble = bit.band(v, 0xF)
    self.nibblePending = true
  else
    self.bytes = self.bytes .. string.pack("B", bit.bor(bit.lshift(bit.band(v, 0xF), 4), self.pendingNibble))
    self.nibblePending = false
  end
end

function Writer:getBytes()
    if self.nibblePending then
        self.bytes = self.bytes .. string.pack("B", bit.lshift(self.pendingNibble, 4))
        self.nibblePending = false
    end
    return self.bytes
end

local Reader = {}
Reader.__index = Reader

function bytbin.newReader(bytes)
    return setmetatable({ bytes = bytes, pos = 1, nibblePending = false, pendingNibble = 0 }, Reader)
end

function Reader:readU8()
  local v = string.unpack("B", self.bytes, self.pos)
  self.pos = self.pos + 1
  return v
end

function Reader:readU16()
  local v = string.unpack("<H", self.bytes, self.pos)
  self.pos = self.pos + 2
  return v
end

function Reader:readFloat()
  local v = string.unpack("f", self.bytes, self.pos)
  self.pos = self.pos + 4
  return v
end

function Reader:readString()
    local v, newpos = string.unpack("s1", self.bytes, self.pos)
    self.pos = newpos
    return v
end

function Reader:readNibble()
  if not self.nibblePending then
    local x = string.unpack("B", self.bytes, self.pos)
    self.pendingNibble = bit.band(x, 0xF)
    self.nibblePending = true
    self.pos = self.pos + 1
    return bit.rshift(bit.band(x, 0xF0), 4)
  else
    self.nibblePending = false
    return self.pendingNibble
  end
end

return bytbin