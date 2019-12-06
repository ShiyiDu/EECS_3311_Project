note
	description: "Summary description for {ROUTINE_PARAMETERS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROUTINE_PARAMETERS
inherit
	ANY
		redefine out
	end
create
	make
feature {NONE}--do a iterator pattern here?
	types: ARRAY[STRING]
	names: ARRAY[STRING]
feature
	routine: detachable CLASS_ROUTINE -- the routine this parameter is for
feature
	make
		do
			create types.make_empty
			create names.make_empty
			names.compare_objects
			types.compare_objects
		end

	set_routine(new_routine: CLASS_ROUTINE)
		do
			routine := new_routine
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

feature
	out: STRING
		do
			create result.make_from_string ("(")
			across types is t loop
				result.append (t)
				result.append (", ")
			end

			if result.count > 1 then
				result.remove_tail (2);
			end
			result.append (")")

			if count = 0 then
				result := ""
			end
		end

invariant
	same_length: types.count = names.count
end
