--[[============================================================================
vLib
============================================================================]]--

require (_clibroot.."cConfig")

class 'vLib'

--------------------------------------------------------------------------------
--- This class provides static members and methods for the vLib library

--- (int) when you instantiate a vLib component, it will register itself
-- with a unique viewbuilder ID. This is the global incrementer
vLib.uid_counter = 0

--- (bool) when true, complex widgets will schedule their updates, 
-- possibly saving a little CPU along the way
vLib.lazy_updates = false

--- (table) set once we access the XML configuration 
vLib.config = nil

-- (table) provide a default color for selected items
vLib.COLOR_SELECTED = {218,96,45}

-- (table) provide a default color for normal (not selected) items
vLib.COLOR_NORMAL = {0x00,0x00,0x00}

--- specify a bitmap which is *guaranteed* to exist (required when 
-- creating bitmap views before assigning the final value)
vLib.DEFAULT_BMP = "Icons/ArrowRight.bmp"

vLib.BITMAP_STYLES = {
  "plain",        -- bitmap is drawn as is, no recoloring is done             
  "transparent",  -- same as plain, but black pixels will be fully transparent
  "button_color", -- recolor the bitmap, using the theme's button color       
  "body_color",   -- same as 'button_back' but with body text/back color      
  "main_color",   -- same as 'button_back' but with main text/back colors     
}

vLib.LARGE_BUTTON_H = 22
vLib.SUBMIT_BT_W = 82

--------------------------------------------------------------------------------
--- generate a unique string that you is used as viewbuilder id for widgets
-- (avoids clashes in names between multiple instances of the same widget)
-- @return string, e.g. "vlib12"

function vLib.generate_uid()
  
  vLib.uid_counter = vLib.uid_counter + 1
  return ("_vlib%i"):format(vLib.uid_counter)

end

--------------------------------------------------------------------------------
-- retrieve values from the default skin/theme

function vLib.get_skin_color(name)
  TRACE("vLib.get_skin_color(name)",name)

  assert(type(name)=="string")

  local default_color = cConfig:get_value("RenoisePrefs/SkinColors/"..name)
  print("default_color",default_color)
  if default_color then
    self.default_button_color = cString.split(default_color,",")
  end

end

