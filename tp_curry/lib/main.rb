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

  

base = Jugador.new("Kyle Lowry", 0.342, 
								 0.215,
								 3.9, 
								 6.7, 
								 0.1, 
								 1.6, 
								 2.1, 
								 15.5)
alero = Jugador.new("Demarre Carroll", 0.415,
									   0.372,
									   4.0, 
									   0.7, 
									   0.4, 
									   1.3, 
									   2.1, 
									   9.7)
alaPivote = Jugador.new("Luis Scola", 0.188, 
									  0.091,
									  2.4,
									  0.0,
									  0.2, 
									  0.3, 
									  2.1, 
									  1.6)


escolta = Jugador.new("DeMar DeRozan",  0.338,
										0.167, 
										4.5, 
										2.8, 
										0.2, 
										1.5, 
										2.1, 
										18.6)
pivote = Jugador.new("Bismack Biyombo", 0.524, 
										0.0, 
										7.7, 
										0.2, 
										0.6, 
										0.2, 
										2.1, 
										4.1)
tecnico = DirectorTecnico.new("tecnico1", {
	KPasesYTiro3.new(3) => 0.5, 
	KPasesYTiro2.new(1) => 0.5
	}, { HombreAHombre.new() => 1.0 })

e1 = Equipo.new("toronto raptors", tecnico, base, alero, alaPivote, escolta, pivote, alero)

#def initialize(nombre, 
# porcentajeDeTirosDeCancha, fg%  
# porcentajeDeTirosDeTresPuntos, 3p% 
# rebotesPorPartido, rpg
# asistenciasPorJuego, apg
# bloqueosPorJuego, bpg
# robosPorJuego, spg
# perdidasPorJuego, to 
# puntosPorPartido, ppg)



base = Jugador.new("Andre Miller", 0.5, 
							0.5, 
							0.7, 
							1.0, 
							0.0, 
							0.0, 
							2.1, 
							2.3)
alero = Jugador.new("Kawhi Leonard", 0.534, 
							  0.556, 
							  6.0, 
							  2.4, 
							  2.0, 
							  2.0, 
							  2.1, 
							  22.3)
alaPivote = Jugador.new("David West", 0.5, 
									  0.5, 
									  3.7, 
									  1.4, 
									  0.7, 
									  0.9, 
									  2.1, 
									  6.1)

#def initialize(nombre, 
# porcentajeDeTirosDeCancha, fg%  
# porcentajeDeTirosDeTresPuntos, 3p% 
# rebotesPorPartido, rpg
# asistenciasPorJuego, apg
# bloqueosPorJuego, bpg
# robosPorJuego, spg
# perdidasPorJuego, to 
# puntosPorPartido, ppg)


escolta = Jugador.new("Manu Ginobilli", 0.469, 
								  0.429, 
								  3.1, 
								  2.9, 
								  0.3, 
								  1.0, 
								  2.1, 
								  7.1)

pivote = Jugador.new("Tim Duncan", 0.438, 
								0.0, 
								5.3, 
								1.9, 
								1.4, 
								0.3, 
								2.1, 
								5.1)
tecnico = DirectorTecnico.new("tecnico2", {
	KPasesYTiro2.new(4) => 0.5, 
	KPasesYTiro3.new(2) => 0.5
	}, { HombreAHombre.new() => 1.0 })

e2 = Equipo.new("San Antonio Spurs", tecnico, base, alero, alaPivote, escolta, pivote, base)


simulacion = Simulacion.new(e1, e2, 40, 6)
puts simulacion

# Testeo de simulacion con al menos un overtime
while(simulacion.historialDeTurnos.size <= 40)
  simulacion = Simulacion.new(e1, e2, 40, 6)
  simulacion.simular
end

puts simulacion
puts "Turnos: " + simulacion.historialDeTurnos.length.to_s
