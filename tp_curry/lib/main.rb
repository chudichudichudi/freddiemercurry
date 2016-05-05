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
require_relative "tecnico.rb"
require_relative "estrategia.rb"

base = Jugador.new("base1", 0.45, 0.368, 3.7, 4.0, 1.4, 0.3, 2.1, 14.1)
alero = Jugador.new("alero1", 0.45, 0.368, 3.7, 4.0, 1.4, 0.3, 2.1, 14.1)
alaPivote = Jugador.new("alaPivote1", 0.45, 0.368, 3.7, 4.0, 1.4, 0.3, 2.1, 14.1)
escolta = Jugador.new("escolta1", 0.45, 0.368, 3.7, 4.0, 1.4, 0.3, 2.1, 14.1)
pivote = Jugador.new("pivote1", 0.45, 0.368, 3.7, 4.0, 1.4, 0.3, 2.1, 14.1)
tecnico = DirectorTecnico.new("tecnico1", {
	KPasesYTiro3.new(3) => 0.5, 
	KPasesYTiro2.new(1) => 0.5
	}, { HombreAHombre.new() => 1.0 })

e1 = Equipo.new("El mejor equipo", tecnico, base, alero, alaPivote, escolta, pivote, alero)


base = Jugador.new("base2", 0.45, 0.368, 3.7, 4.0, 1.4, 0.3, 2.1, 14.1)
alero = Jugador.new("alero2", 0.45, 0.368, 3.7, 4.0, 1.4, 0.3, 2.1, 14.1)
alaPivote = Jugador.new("alaPivote2", 0.45, 0.368, 3.7, 4.0, 1.4, 0.3, 2.1, 14.1)
escolta = Jugador.new("escolta2", 0.45, 0.368, 3.7, 4.0, 1.4, 0.3, 2.1, 14.1)
pivote = Jugador.new("pivote2", 0.45, 0.368, 3.7, 4.0, 1.4, 0.3, 2.1, 14.1)
tecnico = DirectorTecnico.new("tecnico2", {
	KPasesYTiro2.new(4) => 0.5, 
	KPasesYTiro3.new(2) => 0.5
	}, { HombreAHombre.new() => 1.0 })

e2 = Equipo.new("El peor equipo", tecnico, base, alero, alaPivote, escolta, pivote, base)
simulacion = Simulacion.new(e1, e2, 40)
puts simulacion
simulacion.simular

puts simulacion
