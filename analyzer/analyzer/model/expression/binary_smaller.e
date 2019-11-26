note
	description: "Summary description for {BINARY_SMALLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_SMALLER

inherit BINARY_OP

create
	make

feature
	accept(v: VISITOR)
		do
			v.visit_smaller(current)
		end

end
