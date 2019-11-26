note
	description: "Summary description for {PROGRAM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROGRAM
create
	make
feature
	classes: ARRAY[PROGRAM_CLASS]

feature
	make
		do
			create classes.make_empty
		end

	add_class(new_class:PROGRAM_CLASS)
		do
			classes.force (new_class, classes.count+1)
		end

end
