# encoding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "accion.rb"

class Turno
	attr_reader :atacante, :defensor, 
	:puntosAtacante, :puntosDefensor, 
  :quienTieneLaPelota, :pasesSucesivos, :historialDeAccionesYResultados
  

	def initialize(simulacion, atacante, defensor)
		@simulacion = simulacion
    @atacante = atacante
    @estrategiaAtacante = atacante.tecnico.dameEstrategiaOfensiva
		@defensor = defensor
    #@estrategiaDefensor = defensor.tecnico.dameEstrategiaDefensiva
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
    
    ### XXX sacar a una clase
    def resolverAcciones(accionAtacante, accionDefensiva)
      @historialDeAccionesYResultados.push(accionAtacante)
      resultadoDefensivo = accionDefensiva.ejecutar(self)
      @historialDeAccionesYResultados.push(resultadoDefensivo)
      resultadoAtacante = accionAtacante.ejecutar(self, resultadoDefensivo)
      @historialDeAccionesYResultados.push(resultadoAtacante)
      # el orden es lo mismo porque siempre uno de los dos
      # no hace nada
      resultadoAtacante.actualizaTurno(self)
      resultadoDefensivo.actualizaTurno(self)
    end
    
    def cambioPosesion(quienLaTieneAhora)
      @quienTieneLaPelota = quienLaTieneAhora
      @atacante, @defensor = @defensor, @atacante
      @pasesSucesivos = 0
      @estrategiaAtacante = atacante.tecnico.dameEstrategiaOfensiva
      ## estrategia defensiva
    end
    
    def reboteo
      
    end
    
    def sumarPuntosAtacante(puntos)
      @simulacion.sumarPuntosAEquipo(puntos, @atacante)
    end
    
    def simular
      # accionDefensiva
      accionOfensiva = @estrategiaAtacante.obtenerAccion(self)
      accionDefensiva = (accionOfensiva.class.name == "Pase")? 
        IntercepcionPase.new(accionOfensiva, @defensor.base) : 
        AccionDefensivaNula.new(accionOfensiva)
      resolverAcciones(accionOfensiva, accionDefensiva)
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