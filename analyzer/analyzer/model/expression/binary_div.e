note
	description: "Summary description for {BINARY_DIV}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_DIV

inherit BINARY_OP

create
	make

feature
	accept(v: VISITOR)
		do
			v.visit_division(current)
		end

end
