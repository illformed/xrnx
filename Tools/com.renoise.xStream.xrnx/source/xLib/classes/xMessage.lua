--[[============================================================================
xMessage
============================================================================]]--

--[[--

Abstract message class (extend to create your own type)
.
#

### See also 
@{xOscMessage},@{xMidiMessage} 

]]

-------------------------------------------------------------------------------

class 'xMessage' -- (xClass)


--==============================================================================
-- Class Methods
--==============================================================================

function xMessage:__init(...)
  --print("xMessage:__init(...)")

	local args = xLib.unpack_args(...)

  -- args might be a user object - ignore and provide empty table
  if (type(args)~="table") then
    args = {}
  end

  --- number, when message got created
  self.timestamp = os.clock()
  
  --- table<xValue or implementation thereof>
  self.values = property(self.get_values,self.set_values)
  self._values = args.values or {}

  --- int, 1-num_tracks 
  self.track_index = property(self.get_track_index,self.set_track_index)
  self._track_index = args.track_index or rns.selected_track_index

  --- int, 1-num_instruments
  self.instrument_index = property(self.get_instrument_index,self.set_instrument_index)
  self._instrument_index = args.instrument_index or rns.selected_instrument_index

  --- int, 1-12 
  self.note_column_index = property(self.get_note_column_index,self.set_note_column_index)
  self._note_column_index = args.note_column_index or rns.selected_note_column_index

  --- the raw message, as received (or ready to send)
  self.raw_message = property(self.get_raw_message,self.set_raw_message)
  self._raw_message = args.raw_message

  --- table, constructor 
  self.__def = property(self.get_definition)

  -- private --

  self._raw_cache = nil

end

-------------------------------------------------------------------------------
-- Getters/Setters
--------------------------------------------------------------------------------

function xMessage:get_raw_message()
  return self._raw_message
end

function xMessage:set_raw_message(val)
  self._raw_message = val
end

--------------------------------------------------------------------------------

function xMessage:get_values()
  --print("xMessage:get_values()",#self._values)
  return self._values
end

function xMessage:set_values(val)
  assert(type(val)=="table","Expected values to be a table")
  self.values = val
end

--------------------------------------------------------------------------------

function xMessage:get_track_index()
  return self._track_index
end

function xMessage:set_track_index(val)
  assert(type(val)=="number","Expected track_index to be a number")
  self._track_index = val
end

--------------------------------------------------------------------------------

function xMessage:get_instrument_index()
  return self._instrument_index
end

function xMessage:set_instrument_index(val)
  assert(type(val)=="number","Expected instrument_index to be a number")
  self._instrument_index = val
end

--------------------------------------------------------------------------------

function xMessage:get_note_column_index()
  return self._note_column_index
end

function xMessage:set_note_column_index(val)
  assert(type(val)=="number","Expected note_column_index to be a number")
  self._note_column_index = val
end

-------------------------------------------------------------------------------
-- produce a raw message (retrieve from cache if possible)
-- @return 

function xMessage:create_raw_message()
  --TRACE("xMessage:create_raw_message()")

  if self._raw_cache then
    return self._raw_cache
  else
    self._raw_cache = "hello world!"
  end

end


-------------------------------------------------------------------------------

function xMessage:get_definition()

  return {
    values = table.copy(self.values),
    track_index = self.track_index,
    instrument_index = self.instrument_index,
    raw_message = self.raw_message,
  }

end

-------------------------------------------------------------------------------

function xMessage:__tostring()
  return type(self)..": "
    ..", timestamp="..tostring(self.timestamp)
    ..", track_index="..tostring(self.track_index)
    ..", instrument_index="..tostring(self.instrument_index)
    ..", note_column_index="..tostring(self.note_column_index)
    ..", #values="..tostring(#self.values)

end

