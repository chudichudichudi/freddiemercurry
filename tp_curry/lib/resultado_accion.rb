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

class ResultadoPaseFallado < ResultadoAccionOfensiva
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