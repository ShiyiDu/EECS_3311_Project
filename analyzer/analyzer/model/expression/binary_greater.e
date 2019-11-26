note
	description: "Summary description for {BINARY_GREATER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_GREATER

inherit BINARY_OP

create
	make

feature
	accept(v: VISITOR)
		do
			v.visit_greater(current)
		end

end
