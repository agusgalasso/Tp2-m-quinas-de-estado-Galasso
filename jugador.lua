Jugador = {}

Jugador.__index = Jugador

function Jugador:Nuevo(x, y, mapa)

    local o = setmetatable({}, Jugador)

    o.x = x
    o.y = y

    o.ancho = 20
    o.alto = 20

    o.velocidad = 180

    o.vidas = 3

    o.mapa = mapa

    o.atacando = false
    o.tiempoAtaque = 0

    return o

end

function Jugador:Actualizar(dt)

    local dx = 0
    local dy = 0

    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        dx = dx - self.velocidad * dt
    end

    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        dx = dx + self.velocidad * dt
    end

    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
        dy = dy - self.velocidad * dt
    end

    if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
        dy = dy + self.velocidad * dt
    end

    if self.mapa:EsPiso(
        self.x + dx,
        self.y,
        self.ancho,
        self.alto
    ) then

        self.x = self.x + dx

    end

    if self.mapa:EsPiso(
        self.x,
        self.y + dy,
        self.ancho,
        self.alto
    ) then

        self.y = self.y + dy

    end

    if self.tiempoAtaque > 0 then

        self.tiempoAtaque = self.tiempoAtaque - dt

    else

        self.atacando = false

    end

end

function Jugador:Atacar()

    self.atacando = true
    self.tiempoAtaque = 0.2

end

function Jugador:CentroX()

    return self.x + self.ancho / 2

end

function Jugador:CentroY()

    return self.y + self.alto / 2

end

function Jugador:Dibujar()

    if self.atacando then

        love.graphics.setColor(0.2, 0.8, 1)

        love.graphics.circle(
            "fill",
            self:CentroX(),
            self:CentroY(),
            32
        )

    end

    love.graphics.setColor(0.2, 0.5, 1)

    love.graphics.rectangle(
        "fill",
        self.x,
        self.y,
        self.ancho,
        self.alto
    )

end

return Jugador