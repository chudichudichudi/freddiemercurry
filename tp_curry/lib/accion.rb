# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require "resultado_accion.rb"

class Accion
  def initialize
    
  end
  
  def ejecutar(turno)
    raise "subclass responsability"
  end
end


class TiroDe3 < Accion
  attr_reader :tirador

  def initialize(tirador)
    @tirador = tirador
  end
  
  def max(*values)
    values.max
  end
 
  def to_s
    return "#{@tirador} tira de 3"
  end

  def ejecutar(turno, resultadoDefensivo)
    equipo = turno.atacante
    jugador = @tirador
    # falta twitter
    ue = jugador.porcentajeDeTirosDeTresPuntos + 
      (jugador.puntosPorPartido / 2) * 0.01 + 
      max(0.3, jugador.asistenciasPorJuego * 0.025 * turno.pasesSucesivos)
    # entre 0 y 1

    if rand() <= ue
      return ResultadoTiroDe3Acertado.new(self)
    else
      return ResultadoTiroFallado.new(self)
    end
  end
end

class TiroDe2 < Accion
  attr_reader :tirador

  def initialize(tirador)
    @tirador = tirador
  end
  
  def max(*values)
    values.max
  end
 
  def to_s
    return "#{@tirador} tira de 2"
  end

  def ejecutar(turno, resultadoDefensivo)
    equipo = turno.atacante
    jugador = @tirador
    # falta twitter
    ue = jugador.porcentajeDeTirosDeCancha + 
      jugador.puntosPorPartido * 0.01 + 
      max(0.3, jugador.asistenciasPorJuego * 0.025 * turno.pasesSucesivos)
    # entre 0 y 1
    if rand() <= ue
      return ResultadoTiroDe2Acertado.new(self)
    else
      return ResultadoTiroFallado.new(self)
    end
  end
end

class Pase < Accion
  attr_reader :deQuien, :aQuien
  
  def initialize(deQuien, aQuien)
    @deQuien = deQuien
    @aQuien = aQuien
  end
  
  def to_s
    return "#{@deQuien} se la intenta pasar a #{@aQuien}"
  end
  
  def defensivaFallada(turno)
    jugador = @deQuien
    # falta twitter
    ue = 1 - jugador.perdidasPorJuego * 0.01

    # entre 0 y 1
    if rand() <= ue
      return ResultadoPaseAcertado.new(self)
    else
      return ResultadoPaseFallado.new(self)
    end    
  end
  
  def defensivaExitosa(turno)
    return ResultadoNulo.new(self)
  end
  
  def ejecutar(turno, resultadoDefensivo)
    return resultadoDefensivo.resolverConAccionOfensiva(turno, self)
  end
end

class IntercepcionPase < Accion
  attr_reader :pase, :quien
  def initialize(pase, quien)
    @pase = pase
    @quien = quien
  end
  
  def ejecutar(turno)
    jugador = @quien
    # falta twitter
    ue = jugador.robosPorJuego * 0.2

    # entre 0 y 1
    if rand() <= ue
      return ResultadoIntercepcionPaseExitosa.new(self)
    else
      return ResultadoIntercepcionPaseFallada.new(self)
    end
  end
  
end

class AccionDefensivaNula < Accion
  attr_reader :accionOfensiva
  def initialize(accionOfensiva)
    @accionOfensiva
  end
  
  def ejecutar(turno)
    return ResultadoNulo.new(self)
  end
  
end
