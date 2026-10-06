local MaquinaEstado = require("MaquinaEstado")
local EstadoMenu = require("estados.EstadoMenu")
local EstadoJuego = require("estados.EstadoJuego")
local EstadoVictoria = require("estados.EstadoVictoria")
local EstadoDerrota = require("estados.EstadoDerrota")

maquinaEstado = nil

function love.load()

    love.window.setMode(800, 600)

    maquinaEstado = MaquinaEstado:Nuevo()

    local estadoMenu = EstadoMenu:Nuevo(maquinaEstado)
    local estadoJuego = EstadoJuego:Nuevo(maquinaEstado)
    local estadoVictoria = EstadoVictoria:Nuevo(maquinaEstado)
    local estadoDerrota = EstadoDerrota:Nuevo(maquinaEstado)

    maquinaEstado.estadoMenu = estadoMenu
    maquinaEstado.estadoJuego = estadoJuego
    maquinaEstado.estadoVictoria = estadoVictoria
    maquinaEstado.estadoDerrota = estadoDerrota

    maquinaEstado:CambiarEstado(estadoMenu)

end

function love.update(dt)

    if maquinaEstado ~= nil then
        maquinaEstado:Actualizar(dt)
    end

end

function love.draw()

    if maquinaEstado ~= nil then
        maquinaEstado:Dibujar()
    end

end

function love.keypressed(tecla)

    if maquinaEstado ~= nil then
        maquinaEstado:TeclaPresionada(tecla)
    end

end
