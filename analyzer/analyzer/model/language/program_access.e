note
	description: "Summary description for {PROGRAM_ACCESS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

expanded class
	PROGRAM_ACCESS

feature
	program: PROGRAM
		once
			create result.make
		end

feature --query
	--program contains classes
	--classes contain attributes and routines
	--routine contains assignments
	contain_class(name: STRING) : BOOLEAN
		--does the program contain a class with this name?
		do
			result := across program.classes is c some
				c.name ~ name
			end
		end


	contain_attribute(c: PROGRAM_CLASS; name: STRING) : BOOLEAN
		do
			result := across c.attributes is att some
				att.name ~ name
			end
		end

	contain_routine(c: PROGRAM_CLASS; name: STRING) : BOOLEAN
		do
			result := across c.routines is rou some
				rou.name ~ name
			end
		end

	get_attribute_type(c: PROGRAM_CLASS; name: STRING) : STRING
		require
			attribute_exists: contain_attribute(c, name)
		do
			create result.make_empty
			across c.attributes is att loop
				if att.name ~ name then
					result := att.name
				end
			end
		end

	contain_parameter(routine: CLASS_ROUTINE; name: STRING) : BOOLEAN
		do
			result := routine.parameters.contain(name)
		end

	get_parameter_type(routine: CLASS_ROUTINE; name: STRING) : STRING
		require
			parameter_exists: contain_parameter(routine, name)
		do
			result := routine.parameters.get_type(name)
		end

invariant
	program = program

end
