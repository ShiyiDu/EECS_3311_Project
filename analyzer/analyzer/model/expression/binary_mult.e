note
	description: "Summary description for {BINARY_MULT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_MULT

inherit BINARY_OP

feature
	accept(v: VISITOR)
	do
		v.visit_mult(current)
	end

end
