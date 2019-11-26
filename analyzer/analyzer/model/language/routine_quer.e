note
	description: "Summary description for {ROUTINE_QUERY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROUTINE_QUERY
inherit
	CLASS_ROUTINE
create
	make

feature
	accept(v:VISITOR)
		do
			v.visit_query (current)
		end

end
