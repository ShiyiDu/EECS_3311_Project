note
	description: "Summary description for {ROUTINE_QUERY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROUTINE_QUERY
inherit
	CLASS_ROUTINE rename make as routine_make end

create
	make
feature
	make (new_type: STRING; new_name: STRING; new_class: PROGRAM_CLASS)
		local
			default_assign: ROUTINE_ASSIGNMENT
			zero: INT_CONST
			false_value: BOOL_CONST
		do
			routine_make(new_type, new_name, new_class)

			new_type.compare_objects

			if new_type ~ "int" then
				create zero.make (0)
				create default_assign.make ("Result", zero, current)
			else if new_type ~ "bool" then
				create false_value.make (false)
				create default_assign.make ("Result", false_value, current)
			else
				create default_assign.make ("Result", void, current)
			end end
			assignments.force (default_assign, assignments.count+1)
		end

feature
	accept(v:VISITOR)
		do
			v.visit_query (current)
		end

end
