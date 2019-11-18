note
	description: "Summary description for {BINARY_AND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_AND

inherit BINARY_OP

create
	make

feature
	accept(v: VISITOR)
	do
		v.visit_and(current)
	end

end



