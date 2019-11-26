note
	description: "Summary description for {BINARY_EQUAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_EQUAL

inherit BINARY_OP

create
	make

feature
	accept(v: VISITOR)
		do
			v.visit_equal(current)
		end

end
