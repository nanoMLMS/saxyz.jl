#Units used are : KeV, Angstrom, Angstrom^-1
# 1 A-1 = 10 nm^-1

module saxyz


include("cm_coeffs.jl")
include("utils.jl")

using .utils

export hbar_c, I_q, f_thomson , f_resonant

const hbar_c::Float64 = 2. # KeV/Angstrom 
#To convert q in energies use e = hbar_c*q

function I_q(q::Float64 , coords::Vector{Vector{Float64}}, types::Vector{String}, f_res::Dict{String,ComplexF64} )::Float64
	nat=length(coords)
	iq::Float64=0.0
	for i in 1:nat
		for j in 1:nat
			rij = utils.norm(coords[i]-coords[j])
			fi::ComplexF64 = f_thomson(q,types[i]) + f_res[types[i]]
			if types[i] == types[j]
				fj=fi
			else
				fj::ComplexF64 = f_thomson(q,types[j]) + f_res[types[j]]
			end
			iq+=fi*conj(fj)*sinc(q*rij/pi)
		end
	end
	return iq
end

function f_thomson(q::Float64, type::String)::Float64
	as = cm_coeffs[type]["a"]
	bs = cm_coeffs[type]["b"]
	f0::Float64= cm_coeffs[type]["c"]
	for (a,b) in zip(as,bs) 
		f0 += a*exp(-b*(q/4/pi)^2)
	end
	return f0
end

function f_resonant(e::Float64, form_list::Vector{Vector{Float64}})::ComplexF64
	"""
	This finds the resonsant part of scattering form factor for atoms
	"""
	#Units:
	#energies in KeV
	#q in A-1
	#To convert q in energies use e = hbar_c*q
	fmin=nothing
	fmax=nothing
	for fl in form_list
		if fl[1] < e
			fmin=fl[2] + fl[3]im
		elseif fl[1] > e 
			fmax = fl[2] + fl[3]im
			break
		end
	end
	return (fmin+fmax)/2.0
end
	
end #module
