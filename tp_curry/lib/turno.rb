# encoding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Turno
	attr_reader :atacante, :defensor, 
	:puntosAtacante, :puntosDefensor

	def initialize(atacante, defensor)
		@atacante = atacante
		@defensor = defensor
		@puntosDefensor = 0
		@puntosAtacante = 0
  	end

  	def obtenerPuntajeDe(equipo)
  		return (equipo==@atacante)? @puntosAtacante : @puntosDefensor
  	end

  	def quienTieneLaProximaPosesion
  		return @defensor
  	end

  	def posesion
  		return @atacante
  	end

end