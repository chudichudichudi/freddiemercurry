# encoding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require "accion.rb"

class Turno
	attr_reader :atacante, :defensor, 
	:puntosAtacante, :puntosDefensor, 
  :quienTieneLaPelota, :pasesSucesivos, :historialDeAccionesYResultados
  

	def initialize(simulacion, atacante, defensor)
		@simulacion = simulacion
    @atacante = atacante
    #@estrategiaAtacante = atacante.dameEstrategiaOfensiva
		@defensor = defensor
    #@estrategiaDefensor = defensor.dameEstrategiaDefensiva
    @quienTieneLaPelota = atacante.base
    @pasesSucesivos = 0
		@puntosDefensor = 0
		@puntosAtacante = 0
  	@historialDeAccionesYResultados = []
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

    def quienAtaca
      return @atacante
    end

    def quienDefiende
      return @defensor
    end
    
    ### XXX sacar a una clase
    def resolverAcciones(accionAtacante)
      @historialDeAccionesYResultados.push(accionAtacante)
      resultadoAtacante = accionAtacante.ejecutar(self)
      @historialDeAccionesYResultados.push(resultadoAtacante)
      resultadoAtacante.actualizaTurno(self)
    end
    
    def sumarPuntosAtacante(puntos)
      @simulacion.sumarPuntosAEquipo(puntos, @atacante)
    end
    
    def simular
      if (pasesSucesivos == 0)
        accionAtacante = Pase.new(@quienTieneLaPelota, @atacante.alaPivote)
      else 
          accionAtacante = TiroDe3.new(@quienTieneLaPelota)
      end
      # accionDefensiva
      resultado=resolverAcciones(accionAtacante)
    end
    
    def terminar
      @simulacion.siguienteTurnoOFinalizar
    end
    
    def pasarA(aQuien)
      @pasesSucesivos += 1
      @quienTieneLaPelota = aQuien
    end
    
    def to_s
      @historialDeAccionesYResultados.inject("") { | acum, eor | acum + eor.to_s + "\n" }
    end
end