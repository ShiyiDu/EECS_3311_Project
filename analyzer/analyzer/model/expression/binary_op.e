note
	description: "Summary description for {BINARY_OP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BINARY_OP
inherit EXPRESSION

feature
	accept(v: VISITOR)
		deferred
	end
end
