local floor, ceil, lerp = math.floor, math.ceil, math.lerp

class 'ServerPhysics'

function ServerPhysics:__init()
	Events:Subscribe("ModuleLoad", self, self.ModuleLoad)
end

function ServerPhysics:ModuleLoad()
	self.h = terrain.h
	self.data = terrain.data
	terrain = nil
end

function ServerPhysics:GetTerrainHeight(vector)

	local h = self.h
	local x = vector.x + 16384
	local z = (vector.z or vector.y) + 16384
	local data = self.data

	local a = x / h
	local b = z / h

	local x1, x2 = floor(a), ceil(a)
	local z1, z2 = floor(b), ceil(b)

	local t1 = x2 == x1 and 0 or (a - x1) / (x2 - x1)
	local t2 = z2 == z1 and 0 or (b - z1) / (z2 - z1)

	local h1 = data[x1] and data[x1][z1] or 10
	local h2 = data[x2] and data[x2][z1] or 10
	local h3 = data[x1] and data[x1][z2] or 10
	local h4 = data[x2] and data[x2][z2] or 10

	return lerp(lerp(h1, h2, t1), lerp(h3, h4, t1), t2)

end

ServerPhysics = ServerPhysics()
