module utils

export  norm,read_xyz,com,make_chunks1D
export  read_data

"Compute norm"
function norm(vec::Vector{Float64})::Float64
	norm::Float64=0.0
	for ax in vec
		norm += ax*ax
	end
	return sqrt(norm)
end

"Return coordinates and atomic species from a xyz/extxyz file"
function read_xyz(filename::String)
	coords=Vector{Vector{Float64}}(undef,0)
	species::Vector{String}=[]
	nat::Int64=0
	idx=1
	open(filename) do file
		for line in eachline(file)
			if idx==1 
				nat=parse(Int64,line)
			elseif (idx > 2 & idx <= 2+nat)
				push!(species,split(line)[1])
				push!(coords ,[parse(Float64,x) for x in split(line)[2:4]])
			end
			idx+=1
		end
	end
	return coords,species
end

"Finds average position"
function r_zero(coords::Vector{Vector{Float64}})
	com = [0,0,0]
	for at in coords
		com+= at
	end
	return Vector(com/length(coords))
end

"Split a 1D vector in nchunks continous chunks"
function make_chunks1D(qs::Vector{Float64} , nchunks::Int64)
	chunks::Vector{Vector{Float64}}=[ ]
	println(chunks)
	#Get size of chunks
	chunk_size = div(length(qs),nchunks)
	println(chunk_size)
	for c in 1:nchunks-1
		println(c)
		push!(chunks,qs[(c-1)*chunk_size + 1: c*chunk_size ])
	end
	#Last chunks takes everything remaining
	push!(chunks,qs[(nchunks-1)*chunk_size + 1:end])
	return chunks
end

"Read float data in columns from a text file"
function read_data(filename::String)
	idx::Int64=1
	data= []
        open(filename) do file
		for line in eachline(file)
			if startswith(strip(line),'#') # skip comment
				continue
			elseif idx == 1
				data= [Vector{Float64}() for _ in 1:length(split(line))]
			end
			for (x,d) in zip(split(line),data)
			push!(d,parse(Float64,x))
			end
			idx+=1
			end

	end
	return data
end

end #module
