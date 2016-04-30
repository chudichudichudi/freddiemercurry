# encoding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.


class EstadoSimulacion
  def initialize(simulacion)
    @simulacion = simulacion
  end
  
  def to_s
    raise "subclass responsability"
  end
  
	def simular
    raise "subclass responsability"
	end
  
  def siguienteTurnoOFinalizar
    raise "subclass responsability"
  end
end

class EstadoEnCurso < EstadoSimulacion
  def initialize(simulacion, turnosAJugar)
    super(simulacion)
    @turnosAJugar = turnosAJugar
    elPrimerTurno = Turno.new(@simulacion, @simulacion.equipoDesafiado,@simulacion.equipoDesafiante)
    simulacion.agregarTurno(elPrimerTurno)
  end
  
  def to_s
    return "Simulación en curso entre: " + @simulacion.equipoDesafiante.to_s() + " y " +
      @simulacion.equipoDesafiado.to_s() + ".  Puntaje: " + 
      @simulacion.puntajeDesafiante.to_s() + "-" + @simulacion.puntajeDesafiado.to_s()
  end
  
  def elOtroEquipo(equipo)
    return (equipo == @simulacion.equipoDesafiado)? @simulacion.equipoDesafiante : 
      @simulacion.equipoDesafiado;
  end

  def siguienteTurnoOFinalizar()
    if (@simulacion.historialDeTurnos.size() < @turnosAJugar)
      equipoAtacante = turnoActual().quienTieneLaProximaPosesion()
      equipoDefensor = elOtroEquipo(equipoAtacante)
      unNuevoTurno = Turno.new(@simulacion, equipoAtacante, equipoDefensor)
      @simulacion.agregarTurno(unNuevoTurno)
      simular
    else
      @simulacion.terminar
    end
  end
  
  def turnoActual
    @simulacion.historialDeTurnos[-1]
  end

  def simular
    turnoActual().simular
  end
end

class EstadoTerminado < EstadoSimulacion
  def initialize(simulacion)
    super(simulacion)
  end
  
  def to_s()
    return "Simulación Terminada curso entre: " + @simulacion.equipoDesafiante.to_s() + " y " +
      @simulacion.equipoDesafiado.to_s() + ".  Puntaje: " + 
      @simulacion.puntajeDesafiante.to_s() + "-" + @simulacion.puntajeDesafiado.to_s()
  end
  
  def simular
    raise 'El partido ya está finalizado.'
  end

  def siguienteTurnoOFinalizar
    raise 'El partido ya está finalizado.'
  end

end

