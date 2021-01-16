require "scripts/helper";

-- Require data/cookie.lua file
-- Example:
--   token:11111; branch=test;
--   token:22222; branch=develop;
--   token:33333; branch=develop;
filename = "data/cookie.lua"

counter = 1
debug = 0

function init(args)

  -- Initialize the pseudo random number generator - http://lua-users.org/wiki/MathLibraryTutorial
  math.randomseed(os.time())
  math.random(); math.random(); math.random()
  
  paths = non_empty_lines_from(filename)
  
  if #paths <= 0 then
    print("No cookies found. You have to create a file cookies.txt with one cookie per line")
    os.exit()
  end
  
  print("Found " .. #paths .. " cookies")

  local date=os.date("%Y-%m-%d %H:%M:%S");

  io.write("------------------------------\n")
  io.write("[Date]\n")
  io.write("------------------------------\n")
  io.write("  " .. date .. "\n")

  -- Check if arguments are set
  if #args > 0 then
    debug = 1
  end
end

function request() 
  cookie = paths[counter]
  wrk.headers["Cookie"] = cookie

  counter = counter + 1
  if counter > #paths then
    counter = 1
  end

  if debug == 1 then
    io.write("------------------------------\n")
    io.write("[Requests Info]\n")
    io.write("------------------------------\n")
    var_dump(wrk)
  end

  return wrk.format(nil, path, headers)
end

function response(status, headers, body)
  if debug == 1 then
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
  end 
end
