note
	description: "Summary description for {BINARY_ADD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_ADD

inherit BINARY_OP

create
	make

feature
	accept(v: VISITOR)
		do
			v.visit_addition(current)
		end
end
