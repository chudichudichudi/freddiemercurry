# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

## Habría que ir organizando tests de verdad... (Andrés)
require_relative "jugador.rb"
require_relative "equipo.rb"
require_relative "simulacion_en_curso.rb"

e1 = Equipo.new("equipo1", "directorTecnico", "base", "alero", "alaPivote", "escolta", "pivote")
e2 = Equipo.new("equipo2", "directorTecnico", "base", "alero", "alaPivote", "escolta", "pivote")
simulacion = SimulacionEnCurso.new(e1, e2)
puts simulacion