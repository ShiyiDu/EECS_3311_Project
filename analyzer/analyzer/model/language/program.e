note
	description: "Summary description for {PROGRAM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROGRAM
create {PROGRAM_ACCESS}
	make
feature
	classes: ARRAY[PROGRAM_CLASS]

feature {NONE}
	make
		do
			create classes.make_empty
		end

feature
	add_class(new_class:PROGRAM_CLASS)
		do
			classes.force (new_class, classes.count+1)
		end

	accept(v:VISITOR)
		do
			v.visit_program (current)
		end

end
