using Pkg

Pkg.activate("../saxyz")

using Printf
using saxyz

Cu_form_data=Vector{Vector{Float64}}(undef,0)
open("Cu_scattering.dat") do file
	for line in eachline(file)
		if !startswith(strip(line),'#')
			push!(Cu_form_data,[parse(Float64,x) for x in split(line)])
		end
	end
end	

const f_res = Dict( 
		   "Cu" => saxyz.f_resonant(1.0,Cu_form_data)
		   )


#You can plot the form factor as a function of q
open("Cu_form_factor.dat","w") do file
	for q in 0:0.01:10
		iq=saxyz.f_thomson(q,"Cu")
		@printf(file,"%.2f\t%.3f\n",q,iq)
	end
end

filein="particle.xyz"
atoms,types=saxyz.utils.read_xyz(filein)
atoms = [at - saxyz.utils.r_zero(atoms) for at in atoms]
fileout="output.dat"
open(fileout,"w") do file
	println(file,"#q[A]\tI[arb.]")
	for q in logrange(2e-3,2,500)
		iq= saxyz.I_q(q,atoms,types,f_res)
		@printf(file,"%.6f\t%.3f\n",q,iq)
	end
end
