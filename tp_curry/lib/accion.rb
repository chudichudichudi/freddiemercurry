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
  def initialize
    
  end
  
  def max(*values)
    values.max
  end
 
  def ejecutar(turno)
    equipo = turno.atacante
    jugador = turno.quienTieneLaPelota
    # falta twitter
    ue = jugador.porcentajeDeTirosDeTresPuntos + 
      (jugador.puntosPorPartido / 2) * 0.01 + 
      max(0.3, jugador.asistenciasPorJuego * 0.025 * turno.pasesSucesivos)
    # entre 0 y 1
    puts "ue tiro"
    puts ue
    if rand() <= ue
      return ResultadoTiroDe3Acertado.new
    else
      return ResultadoTiroFallado.new
    end
  end
end

class Pase < Accion
  
  def initialize(aQuien)
    @aQuien = aQuien
  end
  
  def ejecutar(turno)
    equipo = turno.atacante
    jugador = turno.quienTieneLaPelota
    # falta twitter
    ue = 1 - jugador.perdidasPorJuego * 0.01

    puts "ue pase"
    puts ue

    # entre 0 y 1
    if rand() <= ue
      return ResultadoPaseAcertado.new(@aQuien)
    else
      return ResultadoPaseFallado.new
    end
  end
end

class ResultadoAccion
  def actualizaTurno(turno)
    raise "Subclass responsability"
  end
end

class ResultadoTiroDe3Acertado < ResultadoAccion
  def actualizaTurno(turno)
    turno.sumarPuntosAtacante(3)
    turno.terminar
  end
end

class ResultadoTiroFallado < ResultadoAccion
  def actualizaTurno(turno)
    turno.terminar
  end
end

class ResultadoPaseAcertado < ResultadoAccion
  def initialize(aQuien)
    @aQuien = aQuien
  end
  
  def actualizaTurno(turno)
    puts "Pase acertado"
    turno.pasarA(@aQuien)
    turno.simular
  end
end

class ResultadoPaseFallado < ResultadoAccion
  def actualizaTurno(turno)
    puts "Pase fallado"
    turno.terminar
  end
end

