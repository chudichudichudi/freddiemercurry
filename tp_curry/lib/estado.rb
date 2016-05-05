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
  def initialize(simulacion, turnosAJugar, turnosTiempoExtra)
    super(simulacion)
    @turnosAJugar = turnosAJugar
    @turnosTiempoExtra = turnosTiempoExtra
    equipos = [@simulacion.equipoDesafiante, @simulacion.equipoDesafiado]
    ## el que saca es uno random
    equipoQueSaca = equipos[rand(0..1)]
    equipoQueNoSaca = elOtroEquipo(equipoQueSaca)
    elPrimerTurno = Turno.new(@simulacion, equipoQueSaca, equipoQueNoSaca)
    simulacion.agregarTurno(elPrimerTurno)
  end
  
  def to_s
    return "Simulación en curso entre: " + @simulacion.equipoDesafiante.to_s() + " y " +
      @simulacion.equipoDesafiado.to_s() + ".  Puntaje: " + 
      @simulacion.puntajeDesafiante.to_s() + "-" + @simulacion.puntajeDesafiado.to_s()
  end
  
  def elOtroEquipo(equipo)
    return @simulacion.elOtroEquipo(equipo)
  end

  def siguienteTurnoOFinalizar()
    # primero verifico si ya termino pero hay empate
    if (@simulacion.historialDeTurnos.size() == @turnosAJugar &&
          @simulacion.puntajeDesafiado == @simulacion.puntajeDesafiante)
        @turnosAJugar += @turnosTiempoExtra
    end
    
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
    start =  "Simulación Terminada entre: " + @simulacion.equipoDesafiante.to_s() + " y " +
      @simulacion.equipoDesafiado.to_s() + ".  Puntaje: " + 
      @simulacion.puntajeDesafiante.to_s() + "-" + @simulacion.puntajeDesafiado.to_s() +
      "\nLog:\n"
      return @simulacion.historialDeTurnos.inject(start) { | acum, turno | acum + turno.to_s + "\n" }
  end
  def simular
    raise 'El partido ya está finalizado.'
  end

  def siguienteTurnoOFinalizar
    raise 'El partido ya está finalizado.'
  end

end

