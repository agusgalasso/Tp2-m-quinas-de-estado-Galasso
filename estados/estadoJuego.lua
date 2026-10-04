local Mapa = require("Mapa")
local Jugador = require("Jugador")
local Enemigo = require("Enemigo")

EstadoJuego = {}

EstadoJuego.__index = EstadoJuego

function EstadoJuego:Nuevo(maquina)

    local o = setmetatable({}, EstadoJuego)

    o.maquina = maquina

    o.mapa = nil
    o.jugador = nil
    o.enemigos = {}

    o.tiempoDano = 0

    o.puntaje = 0

    o.semilla = 0

    o:CrearNivel()

    return o

end

function EstadoJuego:CrearNivel()

    self.semilla = os.time() + math.random(1, 100000)

    math.randomseed(self.semilla)

    self.mapa = Mapa:Nuevo(30, 20, 32)

    local jugadorX, jugadorY = self.mapa:PosicionSala(1)

    self.jugador = Jugador:Nuevo(
        jugadorX,
        jugadorY,
        self.mapa
    )

    self.enemigos = {}

    self:GenerarEnemigos()

    self.tiempoDano = 0

    self.puntaje = 0

end

function EstadoJuego:GenerarEnemigos()

    for i = 2, #self.mapa.salas do

        local cantidad = math.random(1, 2)

        for j = 1, cantidad do

            local x, y = self.mapa:PosicionAleatoriaSala(i)

            local enemigo = Enemigo:Nuevo(
                x,
                y,
                self.mapa
            )

            table.insert(
                self.enemigos,
                enemigo
            )

        end

    end

end

function EstadoJuego:Actualizar(dt)

    self.jugador:Actualizar(dt)

    for _, enemigo in ipairs(self.enemigos) do

        enemigo:Actualizar(
            self.jugador,
            dt
        )

    end

    if self.jugador.atacando then

        for i = #self.enemigos, 1, -1 do

            local enemigo = self.enemigos[i]

            if enemigo:Distancia(self.jugador) < 50 then

                table.remove(
                    self.enemigos,
                    i
                )

                self.puntaje = self.puntaje + 10

            end

        end

    end

    if self.tiempoDano > 0 then

        self.tiempoDano = self.tiempoDano - dt

    end

    for _, enemigo in ipairs(self.enemigos) do

        if enemigo:Colisiona(self.jugador)
        and self.tiempoDano <= 0 then

            self.jugador.vidas =
                self.jugador.vidas - 1

            self.tiempoDano = 1

            local x, y =
                self.mapa:PosicionSala(1)

            self.jugador.x = x
            self.jugador.y = y

            if self.jugador.vidas <= 0 then

                local EstadoDerrota =
                    require("Estados.EstadoDerrota")

                self.maquina:Cambiar(
                    EstadoDerrota:Nuevo(
                        self.maquina,
                        self.puntaje
                    )
                )

                return

            end

        end

    end

    local meta = self.mapa.salas[#self.mapa.salas]

    local metaX =
        (meta.x + 1) * self.mapa.tamano

    local metaY =
        (meta.y + 1) * self.mapa.tamano

    local metaAncho =
        (meta.ancho - 2) * self.mapa.tamano

    local metaAlto =
        (meta.alto - 2) * self.mapa.tamano

    if self.jugador.x < metaX + metaAncho
    and self.jugador.x + self.jugador.ancho > metaX
    and self.jugador.y < metaY + metaAlto
    and self.jugador.y + self.jugador.alto > metaY then

        local EstadoVictoria =
            require("Estados.EstadoVictoria")

        self.maquina:Cambiar(
            EstadoVictoria:Nuevo(
                self.maquina,
                self.puntaje
            )
        )

    end

end

function EstadoJuego:Dibujar()

    self.mapa:Dibujar()

    for _, enemigo in ipairs(self.enemigos) do

        enemigo:Dibujar()

    end

    self.jugador:Dibujar()

    love.graphics.setColor(1, 1, 1)

    love.graphics.print(
        "Vidas: " .. self.jugador.vidas,
        15,
        15
    )

    love.graphics.print(
        "Puntos: " .. self.puntaje,
        15,
        35
    )

    love.graphics.print(
        "R: nueva mazmorra | ESC: menu",
        15,
        55
    )

    love.graphics.print(
        "Semilla: " .. self.semilla,
        15,
        75
    )

end

function EstadoJuego:TeclaPresionada(tecla)

    if tecla == "space" then

        self.jugador:Atacar()

    end

    if tecla == "r" then

        self:CrearNivel()

    end

    if tecla == "escape" then

        local EstadoMenu =
            require("Estados.EstadoMenu")

        self.maquina:Cambiar(
            EstadoMenu:Nuevo(self.maquina)
        )

    end

end

return EstadoJuego