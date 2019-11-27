note
	description: "Summary description for {CLASS_ROUTINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CLASS_ROUTINE
feature
	type: STRING
	name: STRING
	parameters: ROUTINE_PARAMETERS
	assignments: ARRAY[ROUTINE_ASSIGNMENT]
	parent_class: PROGRAM_CLASS --the class that contains this routine
feature
	make (new_type: STRING; new_name: STRING; new_class: PROGRAM_CLASS)
		do
			type := new_type
			name := new_name
			parent_class := new_class
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

feature
	accept(v: VISITOR)
		deferred
		end

end
