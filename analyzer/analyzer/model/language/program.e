note
	description: "Summary description for {PROGRAM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROGRAM
inherit
	ANY redefine out end
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

	out: STRING
		do
			create Result.make_from_string ("")
			Result.append ("%N  Number of classes being specified: " + classes.count.out)
			across classes is c loop
				Result.append( "%N" + c.out)
			end
		end

end
