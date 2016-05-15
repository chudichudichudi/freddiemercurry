# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative "resultado_accion.rb"

class Accion
  def ejecutar(turno)
    raise "subclass responsability"
  end
end

class AccionDefensiva < Accion
  def ejecutar(turno)
    raise "subclass responsability"
  end
end


class AccionOfensiva < Accion
  def ejecutar(turno, resultadoDefensivo)
    raise "subclass responsability"
  end

  def defensivaExitosa(turno)
    raise "subclass responsability"
  end

  def defensivaFallada(turno)
    raise "subclass responsability"
  end

  def esTiro
    raise "subclass responsability"
  end

  def esPase
    raise "subclass responsability"
  end
end  

class TiroDe3 < AccionOfensiva
  attr_reader :tirador

  def esTiro
    return true
  end
  
  def esPase
    return false
  end
  
  def initialize(tirador)
    @tirador = tirador
  end
  
  def max(*values)
    values.max
  end
 
  def to_s
    return "#{@tirador} tira de 3"
  end

  def defensivaFallada(turno)
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

  def defensivaExitosa(turno)
    return ResultadoNulo.new(self)
  end
  
  def ejecutar(turno, resultadoDefensivo)
    return resultadoDefensivo.resolverConAccionOfensiva(turno, self)
  end
end

class TiroDe2 < AccionOfensiva
  attr_reader :tirador

  def initialize(tirador)
    @tirador = tirador
  end
  
  def esTiro
    return true
  end
  
  def esPase
    return false
  end

  def max(*values)
    values.max
  end
 
  def to_s
    return "#{@tirador} tira de 2"
  end

  def defensivaFallada(turno)
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
  
  def defensivaExitosa(turno)
    return ResultadoNulo.new(self)
  end
  
  def ejecutar(turno, resultadoDefensivo)
    return resultadoDefensivo.resolverConAccionOfensiva(turno, self)
  end
end

class Pase < AccionOfensiva
  attr_reader :deQuien, :aQuien
  
  def initialize(deQuien, aQuien)
    @deQuien = deQuien
    @aQuien = aQuien
  end
  
  def esTiro
    return false
  end
  
  def esPase
    return true
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

class AccionDefensivaNula < AccionDefensiva
  attr_reader :accionOfensiva
  def initialize(accionOfensiva)
    @accionOfensiva = accionOfensiva
  end
  
  def ejecutar(turno)
    return ResultadoNulo.new(self)
  end
  
end

class IntercepcionPase < AccionDefensiva
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

class BloqueoTiro < AccionDefensiva
  attr_reader :tiro, :quien
  def initialize(tiro, quien)
    @tiro = tiro
    @quien = quien
  end
  
  def ejecutar(turno)
    jugador = @quien
    # falta twitter
    ue = jugador.bloqueosPorJuego * 0.2
    # entre 0 y 1
    if rand() <= ue
      return ResultadoBloqueoTiroExitoso.new(self)
    else
      return ResultadoBloqueoTiroFallado.new(self)
    end
  end  
end

## no es ni defensiva ni ofensiva
class Reboteo < Accion
  attr_reader :quien, :queEquipo
  def initialize(quien, queEquipo)
    @quien = quien
    @queEquipo = queEquipo
  end
  
  def to_s
    return "#{@quien} de #{@queEquipo} salta"
  end

  def ejecutar(turno)
    jugador = @quien
    # falta twitter
    ue = jugador.rebotesPorPartido * 0.05
    # entre 0 y 1
    if rand() <= ue
      return ResultadoReboteoExitoso.new(self)
    else
      return ResultadoReboteoFallado.new(self)
    end
  end
end