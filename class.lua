local classDirs = {
	"class/?.lua"
}
local classDirToClass = {["class/?.lua"]={}}
local loadedClasses = {}

function loadClass(name)
	local pathized = name:gsub("%.","/")
	if not loadedClasses[name] then
		for i,v in pairs(classDirs) do
			v = v:gsub("%?",pathized)
			if love.filesystem.exists(v) then
				loadedClasses[name] = love.filesystem.load(v)()
				table.insert(classDirToClass[classDirs[i]], name)
				loadedClasses[name].className = name
				loadedClasses[name].package = name:match("^(.+)%..-$")
				local par = getfenv(2)
				local lpart
				for part in name:gmatch("([^%.]+)") do
					par[part] = par[part] or {}
					par[part].parent = par
					par = par[part]
					lpart = part
				end
				par.parent[lpart] = loadedClasses[name]
				break
			end
		end
	end
	return loadedClasses[name]
end

_G.loadClass = loadClass
loadClass "Object"
