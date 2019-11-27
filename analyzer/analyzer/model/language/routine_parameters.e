note
	description: "Summary description for {ROUTINE_PARAMETERS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROUTINE_PARAMETERS
create
	make
feature {NONE}--do a iterator pattern here?
	types: ARRAY[STRING]
	names: ARRAY[STRING]
feature
	routine: CLASS_ROUTINE -- the routine this parameter is for
feature
	make(new_routine: CLASS_ROUTINE)
		do
			create types.make_empty
			create names.make_empty
			routine := new_routine
			names.compare_objects
			types.compare_objects
		end

	add_parameter(type:STRING; name:STRING)
		do
			types.force (type, types.count+1)
			names.force (name, names.count+1)
		end

feature --query
	get_parameter(i: INTEGER): TUPLE[STRING, STRING]
		do
			result := [types[i], names[i]]
		end

	count: INTEGER
		do
			result := types.count;
		end

	accept(v:VISITOR)
		do
			v.visit_parameters (current)
		end

	contain(name: STRING) : BOOLEAN
		do
			result := names.has (name)
		end

	get_type(name: STRING) : STRING
		require
			contain(name)
		local
			i : INTEGER
		do
			create result.make_empty
			from
				i := 1
			until
				i > types.count
			loop
				if names[i]~name then
					result := types[i]
				end
				i := i + 1
			end
		end

invariant
	same_length: types.count = names.count
end
