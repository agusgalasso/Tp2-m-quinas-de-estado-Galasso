EstadoVictoria = {}

EstadoVictoria.__index = EstadoVictoria

function EstadoVictoria:Nuevo(maquina, puntaje)

    local o = setmetatable({}, EstadoVictoria)

    o.maquina = maquina
    o.puntaje = puntaje

    return o

end

function EstadoVictoria:Actualizar(dt)

end

function EstadoVictoria:Dibujar()

    love.graphics.clear(0.05, 0.15, 0.08)

    love.graphics.setColor(1, 1, 1)

    love.graphics.printf(
        "¡VICTORIA!",
        0,
        220,
        960,
        "center"
    )

    love.graphics.printf(
        "Llegaste al final de la mazmorra",
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
        "Presiona R para generar otra mazmorra",
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

function EstadoVictoria:TeclaPresionada(tecla)

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

return EstadoVictoria