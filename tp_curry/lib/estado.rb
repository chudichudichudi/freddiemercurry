# encoding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.


class EstadoSimulacion
  attr_reader :equipoDesafiante, :equipoDesafiado,
      :puntajeDesafiante, :puntajeDesafiado

  def initialize
    raise "subclass responsability"
  end
  
  def to_s
    raise "subclass responsability"
  end
  
	def siguienteTurno
    raise "subclass responsability"
	end

  def posesion
    raise "subclass responsability"
  end

  def turnoActual
    raise "subclass responsability"
  end

end


class EstadoEnCurso < EstadoSimulacion
	attr_reader :equipoDesafiante, :equipoDesafiado,
      :puntajeDesafiante, :puntajeDesafiado, :numeroDeTurno,
      :equipoAtacante, :cantidadDeTurnos
   
  def initialize(equipoDesafiante, equipoDesafiado, turnosAJugar)
    @turnosAJugar = turnosAJugar
    @equipoDesafiante = equipoDesafiante
    @equipoDesafiado = equipoDesafiado
    # Una simulación siempre empieza 0-0
    @puntajeDesafiante = @puntajeDesafiado = 0
    @historialDeTurnos = []

    elPrimerTurno = Turno.new(equipoDesafiado,equipoDesafiante)
    @historialDeTurnos.push(elPrimerTurno)

  end
  
  def to_s
    return "Simulación entre: " + equipoDesafiante.to_s() + " y " +
      equipoDesafiado.to_s() + ".  Puntaje: " + @puntajeDesafiante.to_s() +
      "-" + @puntajeDesafiado.to_s()
  end
  
  def elOtroEquipo(equipo)
    return (equipo == @equipoDesafiado)? @equipoDesafiante : @equipoDesafiado;
  end

  def siguienteTurno
    @puntajeDesafiado += ultimoTurno().obtenerPuntajeDe(@equipoDesafiado)
    @puntajeDesafiante += ultimoTurno().obtenerPuntajeDe(@equipoDesafiante)
    if (@historialDeTurnos.size() < @turnosAJugar)
      equipoAtacante = ultimoTurno().quienTieneLaProximaPosesion()
      equipoDefensor = elOtroEquipo(equipoAtacante)
      unNuevoTurno = Turno.new(equipoAtacante, equipoDefensor)
      @historialDeTurnos.push(unNuevoTurno)
    end
  end

  def turnoActual
    return @historialDeTurnos.size()
  end

  def ultimoTurno
    @historialDeTurnos[-1]
  end

  def posesion
    return ultimoTurno().posesion
  end
end

class Terminado < EstadoSimulacion
	attr_reader :equipoDesafiante, :equipoDesafiado,
      :puntajeDesafiante, :puntajeDesafiado
  
   
  def initialize(equipoDesafiante, equipoDesafiado)
    @equipoDesafiante = equipoDesafiante
    @equipoDesafiado = equipoDesafiado
    # Una simulación siempre empieza 0-0
    @puntajeDesafiante = @puntajeDesafiado = 0
  end
  
  def to_s()
    return "Simulación entre: " + equipoDesafiante.to_s() + " y " +
      equipoDesafiado.to_s() + ".  Puntaje: " + @puntajeDesafiante.to_s() +
      "-" + @puntajeDesafiado.to_s()
  end
  
  def siguienteTurno
    raise 'El partido ya está finalizado.'
  end

end

