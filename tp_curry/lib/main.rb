# encoding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

## Habría que ir organizando tests de verdad... (Andrés)
require "jugador.rb"
require "equipo.rb"
require "simulacion.rb"
require "turno.rb"
require "estado.rb"
require "tecnico.rb"

base = Jugador.new("nombre", 0.45, 0.368, 3.7, 4.0, 1.4, 0.3, 2.1, 14.1)
alero = Jugador.new("nombre", 0.45, 0.368, 3.7, 4.0, 1.4, 0.3, 2.1, 14.1)
alaPivote = Jugador.new("nombre", 0.45, 0.368, 3.7, 4.0, 1.4, 0.3, 2.1, 14.1)
escolta = Jugador.new("nombre", 0.45, 0.368, 3.7, 4.0, 1.4, 0.3, 2.1, 14.1)
pivote = Jugador.new("nombre", 0.45, 0.368, 3.7, 4.0, 1.4, 0.3, 2.1, 14.1)
tecnico = DirectorTecnico.new("nombre")

e1 = Equipo.new("El mejor equipo", tecnico, base, alero, alaPivote, escolta, pivote)


base = Jugador.new("nombre", 0.45, 0.368, 3.7, 4.0, 1.4, 0.3, 2.1, 14.1)
alero = Jugador.new("nombre", 0.45, 0.368, 3.7, 4.0, 1.4, 0.3, 2.1, 14.1)
alaPivote = Jugador.new("nombre", 0.45, 0.368, 3.7, 4.0, 1.4, 0.3, 2.1, 14.1)
escolta = Jugador.new("nombre", 0.45, 0.368, 3.7, 4.0, 1.4, 0.3, 2.1, 14.1)
pivote = Jugador.new("nombre", 0.45, 0.368, 3.7, 4.0, 1.4, 0.3, 2.1, 14.1)
tecnico = DirectorTecnico.new("nombre")

e2 = Equipo.new("El peor equipo", tecnico, base, alero, alaPivote, escolta, pivote)
simulacion = Simulacion.new(e1, e2, 40)
puts simulacion
puts "Turno: #{simulacion.turnoActual()}" 
puts "Le toca a: #{simulacion.posesion()}"

simulacion.simular

puts simulacion
