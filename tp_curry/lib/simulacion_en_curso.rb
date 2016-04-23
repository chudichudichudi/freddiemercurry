# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class SimulacionEnCurso
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
  
  @equipoDesafiante
  @equipoDesafiado
  @puntajeDesafiante
  @puntajeDesafiado
end