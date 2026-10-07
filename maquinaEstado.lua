MaquinaEstado = {}
MaquinaEstado.__index = MaquinaEstado

function MaquinaEstado:Nuevo()
local o = setmetatable({}, MaquinaEstado)
o.estadoActual = nil
return o
end

function MaquinaEstado:Cambiar(nuevoEstado)
self.estadoActual = nuevoEstado
end

function MaquinaEstado:Actualizar(dt)
if self.estadoActual ~= nil then
self.estadoActual:Actualizar(dt)
end
end

function MaquinaEstado:Dibujar()
if self.estadoActual ~= nil then
self.estadoActual:Dibujar()
end
end

function MaquinaEstado:TeclaPresionada(tecla)
if self.estadoActual ~= nil then
self.estadoActual:TeclaPresionada(tecla)
end
end

return MaquinaEstado
