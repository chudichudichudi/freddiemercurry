# encoding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Simulacion
  attr_reader :equipoDesafiante, :equipoDesafiado,
      :puntajeDesafiante, :puntajeDesafiado, :historialDeTurnos
  attr_writer :puntajeDesafiante, :puntajeDesafiado
    
   
  def initialize(equipoDesafiante, equipoDesafiado,turnosAJugar)
    @equipoDesafiante = equipoDesafiante
    @equipoDesafiado = equipoDesafiado
    # Una simulación siempre empieza 0-0
    @puntajeDesafiante = @puntajeDesafiado = 0
    @historialDeTurnos = []
    #TODO: Elegir un equipo atacante al azar
    @estado = EstadoEnCurso.new(self, turnosAJugar)
  end
  
  def to_s
    @estado.to_s
  end
  
  def agregarTurno(turno)
    @historialDeTurnos.push(turno)
  end
  
  def siguienteTurno
    return @estado.jugarTurno
  end

  def turnoActual
    return @estado.turnoActual
  end

  def siguienteTurnoOFinalizar
    return @estado.siguienteTurnoOFinalizar
  end

  def posesion
    return @estado.posesion
  end

  def sumarPuntosAEquipo(puntos, equipo)
    if (equipo == @equipoDesafiante)
      @puntajeDesafiante += puntos
    else
      @puntajeDesafiado += puntos
    end
  end
  
  def terminar
    @estado = EstadoTerminado.new(self);
  end

  def simular
    @estado.simular
  end

  
end
