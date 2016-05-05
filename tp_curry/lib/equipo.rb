# encoding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Equipo
  attr_reader :nombre, :tecnico, :base, :alero, :alaPivote, :escolta, :pivote, :mvp
  def initialize(nombre, tecnico, base, alero, alaPivote, escolta, pivote, mvp)
    @nombre = nombre
    @tecnico = tecnico
    @base = base
    @alero = alero
    @alaPivote = alaPivote
    @escolta = escolta
    @pivote  = pivote
    @jugadores = [@base, @escolta, @alero, @alaPivote, @pivote]
    @mvp = mvp
  end
  
  def jugadorNumero(n)
    return @jugadores[n-1]
  end
  
  def numeroDeJugador(j)
    return @jugadores.index(j) + 1
  end
  
  def to_s
  	@nombre
  end

  def ==(o)
    o.class == self.class && o.state == self.state
  end

  protected

  def state
    self.instance_variables.map { |variable| self.instance_variable_get variable }
  end

end
