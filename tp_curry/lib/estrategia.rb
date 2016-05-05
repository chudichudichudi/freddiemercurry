require_relative "accion.rb"

class Estrategia	
	def obtenerAccion(turno)
		raise "subclass responsability"
	end

	def obtenerDefensiva(turno)
		raise "subclass responsability"
	end

	def actualizarEstrategia(turno)
		raise "subclass responsability"
	end
end

class KPasesYTiro3 < Estrategia
	def initialize(k)
		@cantidadDePasesParaUnTiro = k
	end

	def actualizarEstrategia(turno)
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

class KPasesYTiro2 < Estrategia
	def initialize(k)
		@cantidadDePasesParaUnTiro = k
	end

	def actualizarEstrategia(turno)
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

class EstrategiaDefensiva < Estrategia
	
end