Enemigo = {}

Enemigo.__index = Enemigo

function Enemigo:Nuevo(x, y, mapa)

    local o = setmetatable({}, Enemigo)

    o.x = x
    o.y = y

    o.ancho = 20
    o.alto = 20

    o.velocidad = math.random(50, 90)

    o.mapa = mapa

    return o

end

function Enemigo:Actualizar(jugador, dt)

    local dx = jugador:CentroX() - (self.x + self.ancho / 2)
    local dy = jugador:CentroY() - (self.y + self.alto / 2)

    local distancia = math.sqrt(dx * dx + dy * dy)

    if distancia < 220 and distancia > 1 then

        dx = dx / distancia
        dy = dy / distancia

        local nuevoX = self.x + dx * self.velocidad * dt
        local nuevoY = self.y + dy * self.velocidad * dt

        if self.mapa:EsPiso(
            nuevoX,
            self.y,
            self.ancho,
            self.alto
        ) then

            self.x = nuevoX

        end

        if self.mapa:EsPiso(
            self.x,
            nuevoY,
            self.ancho,
            self.alto
        ) then

            self.y = nuevoY

        end

    end

end

function Enemigo:Colisiona(jugador)

    return self.x < jugador.x + jugador.ancho and
           self.x + self.ancho > jugador.x and
           self.y < jugador.y + jugador.alto and
           self.y + self.alto > jugador.y

end

function Enemigo:Distancia(jugador)

    local dx = (self.x + self.ancho / 2) - jugador:CentroX()
    local dy = (self.y + self.alto / 2) - jugador:CentroY()

    return math.sqrt(dx * dx + dy * dy)

end

function Enemigo:Dibujar()

    love.graphics.setColor(0.9, 0.2, 0.2)

    love.graphics.rectangle(
        "fill",
        self.x,
        self.y,
        self.ancho,
        self.alto
    )

end

return Enemigo