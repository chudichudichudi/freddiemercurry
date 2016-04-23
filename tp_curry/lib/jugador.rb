# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Jugador
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

end