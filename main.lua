local MaquinaEstado = require("MaquinaEstado")
local EstadoMenu = require("Estados.EstadoMenu")

maquinaEstado = nil

function love.load()

    love.window.setMode(960, 640)
    love.window.setTitle("Maquinas de estado")

    math.randomseed(os.time())

    maquinaEstado = MaquinaEstado:Nuevo()
    maquinaEstado:Cambiar(EstadoMenu:Nuevo(maquinaEstado))

end

function love.update(dt)

    maquinaEstado:Actualizar(dt)

end

function love.draw()

    maquinaEstado:Dibujar()

end

function love.keypressed(tecla)

    maquinaEstado:TeclaPresionada(tecla)

end