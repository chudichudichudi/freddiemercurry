# encoding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

## Habría que ir organizando tests de verdad... (Andrés)
require_relative "jugador.rb"
require_relative "equipo.rb"
require_relative "simulacion.rb"
require_relative "turno.rb"
require_relative "estado.rb"

j1 = Jugador.new("nombre", 0, 0, 0, 0, 0, 0, 0, 0)
j1 = Jugador.new("nombre", 0, 0, 0, 0, 0, 0, 0, 0)

j1 = Jugador.new("nombre", 0, 0, 0, 0, 0, 0, 0, 0)

e1 = Equipo.new("equipo1", "directorTecnico", "base", "alero", "alaPivote", "escolta", "pivote")
e2 = Equipo.new("equipo2", "directorTecnico", "base", "alero", "alaPivote", "escolta", "pivote")
simulacion = Simulacion.new(e1, e2,40)

puts simulacion

puts "Turno: #{simulacion.turnoActual()}" 
puts "Le toca a: #{simulacion.posesion()}"
simulacion.siguienteTurno()
puts "Turno: #{simulacion.turnoActual()}" 
puts "Le toca a: #{simulacion.posesion()}"
simulacion.siguienteTurno()
puts "Turno: #{simulacion.turnoActual()}" 
puts "Le toca a: #{simulacion.posesion()}"

