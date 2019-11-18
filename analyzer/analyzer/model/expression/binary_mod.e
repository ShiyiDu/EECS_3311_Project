note
	description: "Summary description for {BINARY_MOD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_MOD

inherit BINARY_OP

create
	make

feature
	accept(v: VISITOR)
	do
		v.visit_modulo(current)
	end

end
