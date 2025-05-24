include("../saxyz.jl")

form_data=Vector{Vector{Float64}}(undef,0)
open("Cu_scattering.dat") do file
	for line in eachline(file)
		if !startswith(strip(line),'#')
			push!(form_data,[parse(Float64,x) for x in split(line)])
		end
	end
end	

const f_res::ComplexF64 = saxyz.f_resonant(1.0,form_data)

"""
You can plot the form factor as a function of q
"""
open("form_factor.dat","w") do file
	for q in 0:0.01:10
		print(file,q)
		print(file," ")
		println(file,f_thomson(q,"Cu"))
	end
end


println("Copper xray atomic form factor at 1 KeV:",f_res)
filein="particle.xyz"
atoms=utils.read_xyz(filein)
atoms = [at - utils.r_zero(atoms) for at in atoms]
fileout="output.dat"
types = ["Cu" for i=1:length(atoms)]
open(fileout,"w") do file
	for q in logrange(2e-3,2,500)
		iq= I_q(q,atoms,types,f_res)
		print(file,q)
		print(file," ")
		println(file,iq)
	end
end
