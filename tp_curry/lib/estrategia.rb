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

class KPasesYTiro < Estrategia
	def initialize(k)
		@cantidadDePasesParaUnTiro = k
	end

	def actualizarEstrategia(turno)
	end

	def obtenerAccion(turno)
    # arreglar, pase aleatorio (no a mi mismo)
		if (turno.pasesSucesivos < @cantidadDePasesParaUnTiro)
		    return Pase.new(turno.quienTieneLaPelota, turno.atacante.alaPivote)
    else 
        return TiroDe3.new(turno.quienTieneLaPelota)
    end
	end
end

class EstrategiaDefensiva < Estrategia
	
end