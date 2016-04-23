# encoding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Simulacion
  attr_reader :equipoDesafiante, :equipoDesafiado,
      :puntajeDesafiante, :puntajeDesafiado
  
   
  def initialize(equipoDesafiante, equipoDesafiado,turnosAJugar)
    @equipoDesafiante = equipoDesafiante
    @equipoDesafiado = equipoDesafiado
    # Una simulación siempre empieza 0-0
    @puntajeDesafiante = @puntajeDesafiado = 0
    #TODO: Elegir un equipo atacante al azar
    @estado = EstadoEnCurso.new(equipoDesafiante,equipoDesafiado,turnosAJugar)
  end
  
  def to_s()
    return "Simulación entre: " + equipoDesafiante.to_s() + " y " +
      equipoDesafiado.to_s() + ".  Puntaje: " + @puntajeDesafiante.to_s() +
      "-" + @puntajeDesafiado.to_s()
  end
  
  def siguienteTurno
    return @estado.siguienteTurno
  end

  def turnoActual
    return @estado.turnoActual
  end

  def posesion
    return @estado.posesion
  end


end

