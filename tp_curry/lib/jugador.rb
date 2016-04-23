# encoding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Jugador

  attr_reader :nombre, :porcentajeDeTirosDeTresPuntos, :porcentajeDeTirosDeCancha, :rebotesPorPartido,
    :asistenciasPorJuego, :bloqueosPorJuego, :robosPorJuego, :perdidasPorJuego, :puntosPorPartido

  def initialize(nombre, porcentajeDeTirosDeCancha, porcentajeDeTirosDeTresPuntos, rebotesPorPartido, asistenciasPorJuego,
                  bloqueosPorJuego, robosPorJuego, perdidasPorJuego, puntosPorPartido)
      @nombre = nombre
      @porcentajeDeTirosDeCancha = porcentajeDeTirosDeCancha
      @porcentajeDeTirosDeTresPuntos = porcentajeDeTirosDeTresPuntos
      @rebotesPorPartido = rebotesPorPartido
      @asistenciasPorJuego = asistenciasPorJuego
      @bloqueosPorJuego = bloqueosPorJuego
      @robosPorJuego = robosPorJuego
      @perdidasPorJuego = perdidasPorJuego
      @puntosPorPartido = puntosPorPartido
  end
  
  def to_s
    @nombre
  end

  def ==(o)
    o.class == self.class && o.state == self.state
  end

  protected

  def state
    self.instance_variables.map { |variable| self.instance_variable_get variable }
  end
end