# encoding: UTF-8
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative "accion.rb"

class Turno
	attr_reader :atacante, :defensor, 
	:puntosAtacante, :puntosDefensor, 
  :quienTieneLaPelota, :pasesSucesivos, 
  :nroPosesion, :historialDeAccionesYResultados
  

	def initialize(simulacion, atacante, defensor)
		@simulacion = simulacion
    @atacante = atacante
    @estrategiaAtacante = atacante.tecnico.dameEstrategiaOfensiva(self)
		@defensor = defensor
    @estrategiaDefensor = defensor.tecnico.dameEstrategiaDefensiva(self)
    @quienTieneLaPelota = atacante.base
    @pasesSucesivos = 0
    @nroPosesion = 0
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
    
    def cambioPosesion(quienLaTieneAhora, queEquipoLaTieneAhora)
      @atacante = queEquipoLaTieneAhora
      @defensor = @simulacion.elOtroEquipo(@atacante)
      @quienTieneLaPelota = quienLaTieneAhora
      @nroPosesion += 1
      @pasesSucesivos = 0
      @estrategiaAtacante = atacante.tecnico.dameEstrategiaOfensiva(self)
      @estrategiaDefensor = defensor.tecnico.dameEstrategiaDefensiva(self)
    end
    
    def reboteo
      posiciones = [5, 4, 3, 2, 1]
      equipos = [ @defensor, @atacante ]
      ultimoRebote = nil
      
      posiciones.each { |pos|  
        equipos.each { |equipo|  
          jugador = equipo.jugadorNumero(pos)
          rebote = Reboteo.new(jugador, equipo)
          ultimoRebote = rebote
          resultado = rebote.ejecutar(self)
          @historialDeAccionesYResultados.push(rebote)
          @historialDeAccionesYResultados.push(resultado)
          resultado.actualizaTurno(self)
          if (resultado.exitoso)
            self.simular
            return ## muy importante!!
          end
        }
      }
      ## si llego acá nadie agarro el rebote, le paso el ultimo rebote
      afuera(ultimoRebote)
    end
    
    def sumarPuntosAtacante(puntos)
      @simulacion.sumarPuntosAEquipo(puntos, @atacante)
    end
    
    def simular
      # accionDefensiva
      accionOfensiva = @estrategiaAtacante.obtenerAccion(self)
      accionDefensiva = @estrategiaDefensor.obtenerAccion(self, accionOfensiva)
      resolverAcciones(accionOfensiva, accionDefensiva)
    end
    
    def afuera(ultimaAccion)
      ra = ResultadoAfuera.new(ultimaAccion)
      @historialDeAccionesYResultados.push(ra)
      ra.actualizaTurno(self)
    end
    
    def terminar
      @simulacion.siguienteTurnoOFinalizar
    end
    
    def pasarA(aQuien)
      @pasesSucesivos += 1
      @quienTieneLaPelota = aQuien
    end
    
    def to_s
      @historialDeAccionesYResultados.inject("") { | acum, eor |
        res = eor.to_s
        acum + (res == ""? "" : res + "\n")        
      }
    end
end