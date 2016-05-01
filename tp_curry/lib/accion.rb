# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

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
    puts "ue tiro"
    puts ue
    if rand() <= ue
      return ResultadoTiroDe3Acertado.new(self)
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
    return "#{@deQuien} se intenta pasar #{@aQuien}"
  end
  
  def defensivaFallada(turno)
    jugador = @deQuien
    # falta twitter
    ue = 1 - jugador.perdidasPorJuego * 0.01

    puts "ue pase"
    puts ue

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

    puts "ue robo pase"
    puts ue

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


class ResultadoAccion
  attr_reader :accion

  def initialize(accion)
    @accion = accion
  end
  
  def actualizaTurno(turno)
    raise "Subclass responsability"
  end
end

class ResultadoNulo < ResultadoAccion
  def initialize(accion)
    super(accion)
  end

  def to_s
    return ""
  end
    
  def actualizaTurno(turno)
    # no hace nada
  end

  def resolverConAccionOfensiva(turno, accionOfensiva)
    return accionOfensiva.defensivaFallada(turno)
  end
end

class ResultadoTiroDe3Acertado < ResultadoAccion
  def initialize(accion)
    super(accion)
  end

  def to_s
    return "#{@accion.tirador} acerto (3 Puntos)"
  end
    
  def actualizaTurno(turno)
    turno.sumarPuntosAtacante(3)
    turno.terminar
  end
end

class ResultadoTiroFallado < ResultadoAccion
  def actualizaTurno(turno)
    turno.terminar
  end

  def to_s
    return "#{@accion.tirador} fallo el tiro.  Se va afuera"
  end
end

class ResultadoPaseAcertado < ResultadoAccion
  def initialize(accion)
    super(accion)
  end
  
  def to_s
    return "#{@accion.aQuien} recibe la pelota"
  end

  def actualizaTurno(turno)
    turno.pasarA(accion.aQuien)
    turno.simular
  end
end

class ResultadoPaseFallado < ResultadoAccion
  def initialize(accion)
    super(accion)
  end

  def to_s
    return "#{@accion.deQuien} fallo el pase.  Se va afuera"
  end

  def actualizaTurno(turno)
    turno.terminar
  end
end


class ResultadoIntercepcionPaseExitosa < ResultadoAccion
  def initialize(accion)
    super(accion)
  end

  def to_s
    return "#{@accion.quien} robo la pelota"
  end

  def actualizaTurno(turno)
    turno.cambioPosesion(@accion.quien)
    turno.simular
  end
  
  def resolverConAccionOfensiva(turno, accionOfensiva)
    return accionOfensiva.defensivaExitosa(turno)
  end
end


class ResultadoIntercepcionPaseFallada < ResultadoAccion
  def initialize(accion)
    super(accion)
  end

  def to_s
    return "#{@accion.quien} no pudo interceptar el pase"
  end

  def actualizaTurno(turno)
    # no hace nada
  end
  
  def resolverConAccionOfensiva(turno, accionOfensiva)
    return accionOfensiva.defensivaFallada(turno)
  end
end