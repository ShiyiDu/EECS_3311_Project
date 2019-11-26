note
	description: "Summary description for {ROUTINE_PARAMETERS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROUTINE_PARAMETERS
create
	make
feature
	types: ARRAY[STRING]
	names: ARRAY[STRING]
feature
	make
		do
			create types.make_empty
			create names.make_empty
		end

	add_parameter(type:STRING; name:STRING)
		do
			types.force (type, types.count+1)
			names.force (name, names.count+1)
		end
invariant
	same_length: types.count = names.count
end
