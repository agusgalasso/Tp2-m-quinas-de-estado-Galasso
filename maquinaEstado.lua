MaquinaEstado = {}
MaquinaEstado.__index = MaquinaEstado

function MaquinaEstado:Nuevo()
    local o = setmetatable({}, MaquinaEstado)

    o.estadoActual = nil

    return o
end

function MaquinaEstado:CambiarEstado(nuevoEstado)

    if self.estadoActual ~= nil then
        if self.estadoActual.salir ~= nil then
            self.estadoActual:salir()
        end
    end

    self.estadoActual = nuevoEstado

    if self.estadoActual ~= nil then
        if self.estadoActual.entrar ~= nil then
            self.estadoActual:entrar()
        end
    end

end

function MaquinaEstado:Actualizar(dt)

    if self.estadoActual ~= nil then
        if self.estadoActual.actualizar ~= nil then
            self.estadoActual:actualizar(dt)
        end
    end

end

function MaquinaEstado:Dibujar()

    if self.estadoActual ~= nil then
        if self.estadoActual.dibujar ~= nil then
            self.estadoActual:dibujar()
        end
    end

end

function MaquinaEstado:TeclaPresionada(tecla)

    if self.estadoActual ~= nil then
        if self.estadoActual.teclaPresionada ~= nil then
            self.estadoActual:teclaPresionada(tecla)
        end
    end

end

return MaquinaEstado
