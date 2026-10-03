EstadoMenu = {}

EstadoMenu.__index = EstadoMenu

function EstadoMenu:Nuevo(maquina)

    local o = setmetatable({}, EstadoMenu)

    o.maquina = maquina

    return o

end

function EstadoMenu:Actualizar(dt)

end

function EstadoMenu:Dibujar()

    love.graphics.clear(0.05, 0.05, 0.08)

    love.graphics.setColor(1, 1, 1)

    love.graphics.printf(
        "MAZMORRA PROCEDURAL",
        0,
        170,
        960,
        "center"
    )

    love.graphics.printf(
        "Cada partida genera una nueva mazmorra",
        0,
        220,
        960,
        "center"
    )

    love.graphics.printf(
        "Presiona ENTER para comenzar",
        0,
        300,
        960,
        "center"
    )

    love.graphics.printf(
        "WASD / Flechas: mover    ESPACIO: atacar",
        0,
        350,
        960,
        "center"
    )

end

function EstadoMenu:TeclaPresionada(tecla)

    if tecla == "return" or tecla == "kpenter" then

        local EstadoJuego = require("Estados.EstadoJuego")

        self.maquina:Cambiar(
            EstadoJuego:Nuevo(self.maquina)
        )

    end

end

return EstadoMenu