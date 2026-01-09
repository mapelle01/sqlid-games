-- 🦑 SQLID Games
-- Juego de eliminación progresiva mediante SQL
-- Cada CTE representa una ronda con nuevos criterios de supervivencia

WITH prueba1 AS (
    -- RONDA 1:
    -- Solo sobreviven los jugadores jóvenes con alta deuda
    SELECT *
    FROM jugador
    WHERE deuda > 1000000
      AND edad < 30
),

prueba2 AS (
    -- RONDA 2:
    -- Se eliminan los jugadores cuyos equipos no fueron ganadores
    SELECT p1.*
    FROM prueba1 p1
    JOIN equipos e
        ON p1.equipo = e.equipo
    WHERE e.resultado = 'Ganador'
),

prueba3 AS (
    -- RONDA 3:
    -- Solo continúan los jugadores con habilidad superior a la media
    SELECT *
    FROM prueba2
    WHERE habilidad > (
        SELECT AVG(habilidad)
        FROM prueba2
    )
),

prueba4 AS (
    -- RONDA FINAL:
    -- Se calcula la puntuación total combinando fuerza y habilidad
    SELECT *,
           (fuerza + habilidad) AS puntuacion_total
    FROM prueba3
)

-- GANADOR FINAL:
-- El jugador con mayor puntuación total tras todas las rondas
SELECT *
FROM prueba4
ORDER BY puntuacion_total DESC
LIMIT 1;
