require "test/unit"
require_relative "../lib/equipo.rb"
require_relative "../lib/jugador.rb"
require_relative "../lib/tecnico.rb"
require_relative "../lib/simulacion.rb"
class TestSimpleNumber < Test::Unit::TestCase
 
  def test_simulacion
  	base = Jugador.new("nombre", 1, 2, 3, 4, 5, 6, 7, 8)
  	alero = Jugador.new("nombre", 1, 2, 3, 4, 5, 6, 7, 8)
  	alaPivote = Jugador.new("nombre", 1, 2, 3, 4, 5, 6, 7, 8)
  	escolta = Jugador.new("nombre", 1, 2, 3, 4, 5, 6, 7, 8)
  	pivote = Jugador.new("nombre", 1, 2, 3, 4, 5, 6, 7, 8)
  	tecnico = DirectorTecnico.new("nombre")

  	equipo = Equipo.new("El mejor equipo", tecnico, base, alero, alaPivote, escolta, pivote)


    base2 = Jugador.new("nombre", 1, 2, 3, 4, 5, 6, 7, 8)
    alero2 = Jugador.new("nombre", 1, 2, 3, 4, 5, 6, 7, 8)
    alaPivote2 = Jugador.new("nombre", 1, 2, 3, 4, 5, 6, 7, 8)
    escolta2 = Jugador.new("nombre", 1, 2, 3, 4, 5, 6, 7, 8)
    pivote2 = Jugador.new("nombre", 1, 2, 3, 4, 5, 6, 7, 8)
    tecnico2 = DirectorTecnico.new("nombre")

    equipo2 = Equipo.new("El mejor equipo", tecnico2, base2, alero2, alaPivote2, escolta2, pivote2)


    simulacion = Simulacion.new(equipo, equipo2,40)

  end

  
end

