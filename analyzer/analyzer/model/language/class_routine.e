note
	description: "Summary description for {CLASS_ROUTINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CLASS_ROUTINE
feature
	name: STRING
	parameters: ROUTINE_PARAMETERS
	assignments: ARRAY[ROUTINE_ASSIGNMENT]
feature
	make (new_name: STRING)
		do
			name := new_name
			create parameters.make
			create assignments.make_empty
		end

	add_parameter(par_type:STRING; par_name:STRING)
		do
			parameters.add_parameter (par_type, par_name)
		end
	add_assignment(new_assign:ROUTINE_ASSIGNMENT)
		do
			assignments.force(new_assign, assignments.count)
		end


end
