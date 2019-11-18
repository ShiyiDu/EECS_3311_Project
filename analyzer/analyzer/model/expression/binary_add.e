note
	description: "Summary description for {BINARY_ADD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_ADD

inherit BINARY_OP

feature
	accept(v: VISITOR)
	do
		v.visit_add(current)
	end
end
