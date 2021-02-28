local typedefs = require "kong.db.schema.typedefs"


return {
  name = "knock-knock",
  fields = {
    {
      -- this plugin will only be applied to Services or Routes
      consumer = typedefs.no_consumer
    },
    {
      -- this plugin will only run within Nginx HTTP module
      protocols = typedefs.protocols_http
    },
    {
      config = {
        type = "record",
        fields = {
            {
              who_is_this = {
                  type = "string",
                  required = true,                    
                  one_of = {
                   "X-Admin-Name",
                   "X-Developer-Name",
                   "X-Tester-Name"
                  },
                  
              },
            },
            {
               responseHeader = {
                   type = "string",
                   required = false,
                   default  = "X-Response-greet"
               } 
            },        
        },
      },
    },
  },
 -- entity_checks = {
    -- Describe your plugin's entity validation rules
  --},
}