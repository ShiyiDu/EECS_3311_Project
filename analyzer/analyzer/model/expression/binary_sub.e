note
	description: "Summary description for {BINARY_SUB}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_SUB

inherit BINARY_OP

feature
	accept(v: VISITOR)
	do
		v.visit_sub(current)
	end

end
