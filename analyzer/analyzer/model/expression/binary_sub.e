note
	description: "Summary description for {BINARY_SUB}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_SUB

inherit BINARY_OP

create
	make

feature
	accept(v: VISITOR)
		do
			v.visit_substraction(current)
		end

end
