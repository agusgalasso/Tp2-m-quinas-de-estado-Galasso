EstadoDerrota = {}

EstadoDerrota.__index = EstadoDerrota

function EstadoDerrota:Nuevo(maquina, puntaje)

    local o = setmetatable({}, EstadoDerrota)

    o.maquina = maquina
    o.puntaje = puntaje

    return o

end

function EstadoDerrota:Actualizar(dt)

end

function EstadoDerrota:Dibujar()

    love.graphics.clear(0.15, 0.05, 0.05)

    love.graphics.setColor(1, 1, 1)

    love.graphics.printf(
        "DERROTA",
        0,
        220,
        960,
        "center"
    )

    love.graphics.printf(
        "Te quedaste sin vidas",
        0,
        270,
        960,
        "center"
    )

    love.graphics.printf(
        "Puntaje: " .. self.puntaje,
        0,
        320,
        960,
        "center"
    )

    love.graphics.printf(
        "Presiona R para intentar nuevamente",
        0,
        370,
        960,
        "center"
    )

    love.graphics.printf(
        "Presiona ESC para volver al menu",
        0,
        410,
        960,
        "center"
    )

end

function EstadoDerrota:TeclaPresionada(tecla)

    if tecla == "r" then

        local EstadoJuego =
            require("Estados.EstadoJuego")

        self.maquina:Cambiar(
            EstadoJuego:Nuevo(self.maquina)
        )

    end

    if tecla == "escape" then

        local EstadoMenu =
            require("Estados.EstadoMenu")

        self.maquina:Cambiar(
            EstadoMenu:Nuevo(self.maquina)
        )

    end

end

return EstadoDerrota