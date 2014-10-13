local config = setmetatable( {
	name = "hirveserv",
	port = 4050,
	auth = false,
	bcryptRounds = 5,
	tempAuthDuration = 60,
	chroot = false,
	runas = false,
}, { __index = { } } )

local fn, err = loadfile( "config.lua", "t", config )
if not fn then
	log.warn( "couldn't read config: %s", err )

	return config
end

if _VERSION == "Lua 5.1" then
	setfenv( fn, config )
end

local ok, err_run = pcall( fn )
if not ok then
	log.error( "reading config.lua failed: %s", err )

	os.exit( 1 )
end

return config
