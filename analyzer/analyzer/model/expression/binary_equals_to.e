note
	description: "Summary description for {BINARY_EQUALS_TO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_EQUALS_TO

inherit BINARY_OP

create
	make

feature
	accept(v: VISITOR)
	do
		v.visit_equals_to(current)
	end

end



