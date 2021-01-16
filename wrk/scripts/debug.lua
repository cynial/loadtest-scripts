require "scripts/helper";

-- Require data/debug.lua file
-- Example:
-- wrk.method = "GET"
-- wrk.body   = "foo=111&baz=quux"
-- wrk.headers["Content-Type"] = "application/x-www-form-urlencoded"
require "data/debug";

local max_requests = 1
local counter = 1

function setup(thread)
   thread:set("id", counter)

   counter = counter + 1

end

function init(args)

  local date=os.date("%Y-%m-%d %H:%M:%S");

  io.write("------------------------------\n")
  io.write("[Date]\n")
  io.write("------------------------------\n")
  io.write("  " .. date .. "\n")

  -- Check if arguments are set
  if #args > 0 then
    io.write("------------------------------\n")
    io.write("[Init Arguments]\n")
    io.write("------------------------------\n")

    -- Loop through passed arguments
    for index, value in ipairs(args) do
      io.write("- " .. args[index] .. "\n")
    end
  end
  io.write("------------------------------\n")
  io.write("[Wrk Running]\n")
  io.write("------------------------------\n")
end

function response(status, headers, body)
  io.write("------------------------------\n")
  io.write("[Response Status]\n")
  io.write("------------------------------\n")
  io.write("  " .. status .. "\n")

  io.write("------------------------------\n")
  io.write("[Response Headers]\n")
  io.write("------------------------------\n")

  -- Loop through passed arguments
  for key, value in pairs(headers) do
    io.write("  " .. key  .. ": " .. value .. "\n")
  end

  io.write("------------------------------\n")
  io.write("[Response Body]\n")
  io.write("------------------------------\n")
  io.write("  " .. body .. "\n")
  io.write("------------------------------\n")
  io.write("[Wrk Result]\n")
  io.write("------------------------------\n")

  -- Stop after max_requests if max_requests is a positive number
  if (max_requests > 0) and (counter >= max_requests) then
    wrk.thread:stop()
  end

  counter = counter + 1
end

function done(summary, latency, requests)
  io.write("------------------------------\n")
  io.write("[Requests Info]\n")
  io.write("------------------------------\n")
  var_dump(wrk)
end
