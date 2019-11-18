note
	description: "Summary description for {BINARY_OR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_OR

inherit BINARY_OP

create
	make

feature
	accept(v: VISITOR)
	do
		v.visit_or(current)
	end

end



