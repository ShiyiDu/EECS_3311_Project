note
	description: "Summary description for {ROUTINE_ASSIGNMENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROUTINE_ASSIGNMENT

create
	make

feature
	name: STRING
	exp: EXPRESSION

feature
	make(new_name: STRING; new_exp: EXPRESSION)
		do
			name := new_name
			exp := new_exp
		end

end
