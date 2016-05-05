class ResultadoAccion
  attr_reader :accion

  def initialize(accion)
    @accion = accion
  end
  
  def actualizaTurno(turno)
    raise "Subclass responsability"
  end
end

class ResultadoAccionOfensiva < ResultadoAccion
  def initialize(accion)
    super(accion)
  end
end

class ResultadoAccionDefensiva < ResultadoAccion
  def initialize(accion)
    super(accion)
  end

  def resolverConAccionOfensiva(turno, accionOfensiva)
    raise "Subclass responsability"
  end
end


class ResultadoReboteo < ResultadoAccion
  def initialize(accion)
    super(accion)
  end

  def exitoso
    raise "Subclass responsability"
  end
end


class ResultadoNulo < ResultadoAccionDefensiva
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

## TODO juntar estos dos y agregar parametro?
class ResultadoTiroDe3Acertado < ResultadoAccionOfensiva
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

class ResultadoTiroDe2Acertado < ResultadoAccionOfensiva
  def initialize(accion)
    super(accion)
  end

  def to_s
    return "#{@accion.tirador} acerto (2 Puntos)"
  end
    
  def actualizaTurno(turno)
    turno.sumarPuntosAtacante(2)
    turno.terminar
  end
end

class ResultadoTiroFallado < ResultadoAccionOfensiva
  def actualizaTurno(turno)
    turno.afuera(accion)
  end

  def to_s
    return "#{@accion.tirador} fallo el tiro"
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

class ResultadoPaseFallado < ResultadoAccionOfensiva
  def initialize(accion)
    super(accion)
  end

  def to_s
    return "#{@accion.deQuien} fallo el pase"
  end

  def actualizaTurno(turno)
    turno.afuera(accion)
  end
end


class ResultadoIntercepcionPaseExitosa < ResultadoAccionDefensiva
  def initialize(accion)
    super(accion)
  end

  def to_s
    return "#{@accion.quien} robo la pelota"
  end

  def actualizaTurno(turno)
    turno.cambioPosesion(@accion.quien, turno.defensor)
    turno.simular
  end
  
  def resolverConAccionOfensiva(turno, accionOfensiva)
    return accionOfensiva.defensivaExitosa(turno)
  end
end


class ResultadoIntercepcionPaseFallada < ResultadoAccionDefensiva
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

class ResultadoBloqueoTiroExitoso < ResultadoAccionDefensiva
  def initialize(accion)
    super(accion)
  end

  def to_s
    return "#{@accion.quien} bloqueo el tiro, la pelota queda en el aire"
  end

  def actualizaTurno(turno)
    turno.reboteo
  end
  
  def resolverConAccionOfensiva(turno, accionOfensiva)
    return accionOfensiva.defensivaExitosa(turno)
  end
end


class ResultadoBloqueoTiroFallado < ResultadoAccionDefensiva
  def initialize(accion)
    super(accion)
  end

  def to_s
    return "#{@accion.quien} no pudo bloquear el tiro"
  end

  def actualizaTurno(turno)
    # no hace nada
  end
  
  def resolverConAccionOfensiva(turno, accionOfensiva)
    return accionOfensiva.defensivaFallada(turno)
  end
end


class ResultadoReboteoExitoso < ResultadoReboteo
  def initialize(accion)
    super(accion)
  end

  def to_s
    return "#{@accion.quien} agarra el rebote"
  end

  def actualizaTurno(turno)
    turno.cambioPosesion(accion.quien, accion.queEquipo)
  end
  
  def exitoso
    return true
  end
end

class ResultadoReboteoFallado < ResultadoReboteo
  def initialize(accion)
    super(accion)
  end

  def to_s
    return "#{@accion.quien} no pudo agarrar el rebote"
  end

  def actualizaTurno(turno)
    # no hace nada
  end
  
  def exitoso
    return false
  end
end

## esto quedo medio colgado, habria que revisar el reboteo
class ResultadoAfuera < ResultadoAccion
  def initialize(ultimaAccion)
    super(ultimaAccion)
  end
  
  def to_s
    return "la pelota se va afuera"
  end

  def actualizaTurno(turno)
    turno.terminar
  end
end