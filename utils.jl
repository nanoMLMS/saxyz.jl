module utils

export  norm,read_xyz,com

"Compute norm"
function norm(vec::Vector{Float64})::Float64
	norm::Float64=0.0
	for ax in vec
		norm += ax*ax
	end
	return sqrt(norm)
end

"Return coordinates from a xyz/extxyz file"
function read_xyz(filename::String)
	coords=Vector{Vector{Float64}}(undef,0)
	nat::Int64=0
	idx=1
	open(filename) do file
		for line in eachline(file)
			if idx==1 
				nat=parse(Int64,line)
			elseif (idx > 2 & idx <= 2+nat) 
				push!(coords,[parse(Float64,x) for x in split(line)[2:4]])
			end
			idx+=1
		end
	end
	return coords
end

"Finds average position"
function r_zero(coords::Vector{Vector{Float64}})
	com = [0,0,0]
	for at in coords
		com+= at
	end
	return Vector(com/length(coords))
end

end #module
