note
	description: "Summary description for {BINARY_DIV}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_DIV

inherit BINARY_OP

feature
	accept(v: VISITOR)
	do
		v.visit_div(current)
	end

end
