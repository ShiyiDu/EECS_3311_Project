note
	description: "Summary description for {ROUTINE_COMMAND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROUTINE_COMMAND
inherit
	CLASS_ROUTINE
create
	make

feature
	accept(v:VISITOR)
		do
			v.visit_command (current)
		end
end
