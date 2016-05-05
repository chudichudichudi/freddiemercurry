require_relative "accion.rb"

class Estrategia	
end

class EstrategiaOfensiva < Estrategia
	def obtenerAccion(turno)
		raise "subclass responsability"
	end
end


class EstrategiaDefensiva < Estrategia
	def obtenerAccion(turno, accionOfensiva)
		raise "subclass responsability"
	end
end

class KPasesYTiro3 < EstrategiaOfensiva
	def initialize(k)
		@cantidadDePasesParaUnTiro = k
	end

	def obtenerAccion(turno)
		if (turno.pasesSucesivos < @cantidadDePasesParaUnTiro)
        aQuien = turno.quienTieneLaPelota
        while(aQuien == turno.quienTieneLaPelota)
          aQuien = turno.atacante.jugadorNumero(rand(1..5)) 
        end
		    return Pase.new(turno.quienTieneLaPelota, aQuien)
    else 
        return TiroDe3.new(turno.quienTieneLaPelota)
    end
	end
end

class KPasesYTiro2 < EstrategiaOfensiva
	def initialize(k)
		@cantidadDePasesParaUnTiro = k
	end

	def obtenerAccion(turno)
		if (turno.pasesSucesivos < @cantidadDePasesParaUnTiro)
        aQuien = turno.quienTieneLaPelota
        while(aQuien == turno.quienTieneLaPelota)
          aQuien = turno.atacante.jugadorNumero(rand(1..5)) 
        end
		    return Pase.new(turno.quienTieneLaPelota, aQuien)
    else 
        return TiroDe2.new(turno.quienTieneLaPelota)
    end
	end
end

class HombreAHombre < EstrategiaDefensiva
	def obtenerAccion(turno, accionOfensiva)
		if (accionOfensiva.esPase)
      nroContrario = turno.atacante.numeroDeJugador(accionOfensiva.deQuien)
      miJugador = turno.defensor.jugadorNumero(nroContrario)
      return IntercepcionPase.new(accionOfensiva, miJugador)
    else 
      ## TODO que pasa con contrataque?
      nroContrario = turno.atacante.numeroDeJugador(accionOfensiva.tirador)
      miJugador = turno.defensor.jugadorNumero(nroContrario)
      return BloqueoTiro.new(accionOfensiva, miJugador)
    end
	end
  
end