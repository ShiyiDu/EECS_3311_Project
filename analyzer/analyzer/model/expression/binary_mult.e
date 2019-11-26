note
	description: "Summary description for {BINARY_MULT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_MULT

inherit BINARY_OP

create
	make

feature
	accept(v: VISITOR)
		do
			v.visit_multiplication(current)
		end

end
