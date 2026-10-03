Mapa = {}

Mapa.__index = Mapa

function Mapa:Nuevo(columnas, filas, tamano)

    local o = setmetatable({}, Mapa)

    o.columnas = columnas
    o.filas = filas
    o.tamano = tamano

    o.salas = {}
    o.matriz = {}

    o:Generar()

    return o

end

function Mapa:Generar()

    for y = 1, self.filas do

        self.matriz[y] = {}

        for x = 1, self.columnas do

            self.matriz[y][x] = false

        end

    end

    local intentos = 0

    while #self.salas < 6 and intentos < 1000 do

        intentos = intentos + 1

        local ancho = math.random(5, 8)
        local alto = math.random(4, 6)

        local x = math.random(2, self.columnas - ancho - 1)
        local y = math.random(2, self.filas - alto - 1)

        local nuevaSala = {
            x = x,
            y = y,
            ancho = ancho,
            alto = alto
        }

        local superpuesta = false

        for _, sala in ipairs(self.salas) do

            if nuevaSala.x < sala.x + sala.ancho + 1
            and nuevaSala.x + nuevaSala.ancho + 1 > sala.x
            and nuevaSala.y < sala.y + sala.alto + 1
            and nuevaSala.y + nuevaSala.alto + 1 > sala.y then

                superpuesta = true
                break

            end

        end

        if not superpuesta then

            table.insert(self.salas, nuevaSala)

            self:CrearSala(nuevaSala)

        end

    end

    for i = 2, #self.salas do

        local salaAnterior = self.salas[i - 1]
        local salaActual = self.salas[i]

        local x1 = math.floor(salaAnterior.x + salaAnterior.ancho / 2)
        local y1 = math.floor(salaAnterior.y + salaAnterior.alto / 2)

        local x2 = math.floor(salaActual.x + salaActual.ancho / 2)
        local y2 = math.floor(salaActual.y + salaActual.alto / 2)

        self:CrearPasilloHorizontal(x1, x2, y1)
        self:CrearPasilloVertical(y1, y2, x2)

    end

end

function Mapa:CrearSala(sala)

    for y = sala.y, sala.y + sala.alto - 1 do

        for x = sala.x, sala.x + sala.ancho - 1 do

            if self.matriz[y] ~= nil then

                self.matriz[y][x] = true

            end

        end

    end

end

function Mapa:CrearPasilloHorizontal(x1, x2, y)

    local inicio = math.min(x1, x2)
    local final = math.max(x1, x2)

    for x = inicio, final do

        if self.matriz[y] ~= nil then

            self.matriz[y][x] = true

        end

    end

end

function Mapa:CrearPasilloVertical(y1, y2, x)

    local inicio = math.min(y1, y2)
    local final = math.max(y1, y2)

    for y = inicio, final do

        if self.matriz[y] ~= nil then

            self.matriz[y][x] = true

        end

    end

end

function Mapa:EsPiso(x, y, ancho, alto)

    local izquierda = math.floor(x / self.tamano) + 1
    local derecha = math.floor((x + ancho - 1) / self.tamano) + 1

    local arriba = math.floor(y / self.tamano) + 1
    local abajo = math.floor((y + alto - 1) / self.tamano) + 1

    if izquierda < 1 or arriba < 1 then
        return false
    end

    if derecha > self.columnas or abajo > self.filas then
        return false
    end

    for fila = arriba, abajo do

        for columna = izquierda, derecha do

            if self.matriz[fila][columna] == false then
                return false
            end

        end

    end

    return true

end

function Mapa:PosicionSala(numero)

    local sala = self.salas[numero]

    local x = (sala.x + sala.ancho / 2) * self.tamano
    local y = (sala.y + sala.alto / 2) * self.tamano

    return x - 10, y - 10

end

function Mapa:PosicionAleatoriaSala(numero)

    local sala = self.salas[numero]

    local x = math.random(sala.x + 1, sala.x + sala.ancho - 2)
    local y = math.random(sala.y + 1, sala.y + sala.alto - 2)

    return x * self.tamano + 5, y * self.tamano + 5

end

function Mapa:Dibujar()

    love.graphics.setColor(0.08, 0.08, 0.12)

    love.graphics.rectangle(
        "fill",
        0,
        0,
        self.columnas * self.tamano,
        self.filas * self.tamano
    )

    for y = 1, self.filas do

        for x = 1, self.columnas do

            if self.matriz[y][x] then

                love.graphics.setColor(0.25, 0.25, 0.30)

                love.graphics.rectangle(
                    "fill",
                    (x - 1) * self.tamano,
                    (y - 1) * self.tamano,
                    self.tamano - 1,
                    self.tamano - 1
                )

            end

        end

    end

    local meta = self.salas[#self.salas]

    love.graphics.setColor(0.2, 0.8, 0.3)

    love.graphics.rectangle(
        "fill",
        (meta.x + 1) * self.tamano,
        (meta.y + 1) * self.tamano,
        (meta.ancho - 2) * self.tamano,
        (meta.alto - 2) * self.tamano
    )

end

return Mapa