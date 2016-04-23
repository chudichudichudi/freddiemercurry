# encoding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.


class Estado
  attr_reader :equipoDesafiante, :equipoDesafiado,
      :puntajeDesafiante, :puntajeDesafiado
  
   
  def initialize
  end
  
  def to_s()
    return "Simulación entre: " + equipoDesafiante.to_s() + " y " +
      equipoDesafiado.to_s() + ".  Puntaje: " + @puntajeDesafiante.to_s() +
      "-" + @puntajeDesafiado.to_s()
  end
  
	def siguienteTurno
	end


end


class EnCurso<Estado
	attr_reader :equipoDesafiante, :equipoDesafiado,
      :puntajeDesafiante, :puntajeDesafiado, :numeroDeTurno,
      :equipoAtacante, :cantidadDeTurnos

  
   
  def initialize(equipoDesafiante, equipoDesafiado, turnosAJugar)
    @turnosAJugar = turnosAJugar
    @equipoDesafiante = equipoDesafiante
    @equipoDesafiado = equipoDesafiado
    # Una simulación siempre empieza 0-0
    @puntajeDesafiante = @puntajeDesafiado = 0
    @numeroDeTurno = 1
    @historialDeTurnos = []

    elPrimerTurno = Turno.new(A)
    @historialDeTurnos.add(elPrimerTurno)

  end
  
  def to_s()
    return "Simulación entre: " + equipoDesafiante.to_s() + " y " +
      equipoDesafiado.to_s() + ".  Puntaje: " + @puntajeDesafiante.to_s() +
      "-" + @puntajeDesafiado.to_s()
  end
  
  def siguienteTurno
    @puntajeDesafiado += @historialDeTurnos.last().obtenerDePuntajeDe(@equipoDesafiado)
    @puntajeDesafiante += @historialDeTurnos.last().obtenerDePuntajeDe(@equipoDesafiante)
    if (@historialDeTurnos.size() < @turnosAJugar)
      equipoAtacante = @historialDeTurnos.last().quieneTieneLaProximaPosesion()
      unNuevoTurno = Turno.new(equipoAtacante,theOtherOne)
      historialDeTurnos.add(elPrimerTurno)
    end
    
  end
end

class Terminado<Estado
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
  @equipoDesafiante
  @equipoDesafiado
  @puntajeDesafiante
  @puntajeDesafiado
end

