local BasePlugin = require "kong.plugins.base_plugin"

local knockHandler = BasePlugin:extend()

knockHandler.PRIORITY = 2400
knockHandler.VERSION = "0.1.0"

function knockHandler:new()
    knockHandler.super.new(self, "kong-plugin-header-echo")

  self.user_name = ""
end


function knockHandler:access(conf)
    knockHandler.super.access(self)

 
  local headers = kong.request.get_headers()
  if(headers.x_admin_name~=nil)
  then
    self.user_name = headers.x_admin_name
  elseif(headers.x_developer_name~=nil)  
  then
    self.user_name = headers.x_developer_name
  elseif(headers.x_tester_name~=nil) 
  then
    self.user_name = headers.x_tester_name
  else
    --send the error response
    return kong.response.exit(403, "Access Forbidden")
  end    

  
end

-- Run this when the response header has been received
-- from the upstream service
function knockHandler:header_filter(conf)
    knockHandler.super.header_filter(self)  
    self.user_name = "hey!!!" .. self.user_name
    kong.response.set_header(conf.responseHeader, self.user_name)
  
end

return knockHandler
