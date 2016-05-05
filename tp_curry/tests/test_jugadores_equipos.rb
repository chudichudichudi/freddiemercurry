require "test/unit"
require_relative "../lib/equipo.rb"
require_relative "../lib/jugador.rb"
require_relative "../lib/tecnico.rb"
class TestSimpleNumber < Test::Unit::TestCase
 
  def test_jugador
  	jugador = Jugador.new("nombre", 1, 2, 3, 4, 5, 6, 7, 8)

    assert_equal(jugador.nombre, "nombre")
    assert_equal(jugador.porcentajeDeTirosDeCancha, 1)
    assert_equal(jugador.porcentajeDeTirosDeTresPuntos, 2)
    assert_equal(jugador.rebotesPorPartido, 3)
    assert_equal(jugador.asistenciasPorJuego, 4)
    assert_equal(jugador.bloqueosPorJuego, 5)
    assert_equal(jugador.robosPorJuego, 6)
    assert_equal(jugador.perdidasPorJuego, 7)
    assert_equal(jugador.puntosPorPartido, 8)
  end

  def test_equipo
  	base = Jugador.new("nombre", 1, 2, 3, 4, 5, 6, 7, 8)
  	alero = Jugador.new("nombre", 1, 2, 3, 4, 5, 6, 7, 8)
  	alaPivote = Jugador.new("nombre", 1, 2, 3, 4, 5, 6, 7, 8)
  	escolta = Jugador.new("nombre", 1, 2, 3, 4, 5, 6, 7, 8)
  	pivote = Jugador.new("nombre", 1, 2, 3, 4, 5, 6, 7, 8)
  	tecnico = DirectorTecnico.new("nombre")
    mvp = base
    
  	equipo = Equipo.new("El mejor equipo", tecnico, base, alero, alaPivote, escolta, pivote, mvp)

    assert_equal(equipo.tecnico, tecnico)
    assert_equal(equipo.base, base)
    assert_equal(equipo.alero, alero)
    assert_equal(equipo.alaPivote, alaPivote)
    assert_equal(equipo.escolta, escolta)
    assert_equal(equipo.pivote, pivote)
    assert_equal(equipo.nombre, "El mejor equipo")
    assert_equal(equipo.mvp, base)
  end

  
end