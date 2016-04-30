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

  def ejecutar(turno)
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
  
  def ejecutar(turno)
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
    puts "Pase acertado"
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
    puts "Pase fallado"
    turno.terminar
  end
end

