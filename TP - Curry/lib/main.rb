# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

## Habría que ir organizando tests de verdad... (Andrés)
require "jugador.rb"
require "equipo.rb"
require "simulacion_en_curso.rb"

e1 = Equipo.new()
e2 = Equipo.new()
simulacion = SimulacionEnCurso.new(e1, e2)
print simulacion