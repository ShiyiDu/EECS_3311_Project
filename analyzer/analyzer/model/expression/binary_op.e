note
	description: "Summary description for {BINARY_OP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BINARY_OP
inherit EXPRESSION COMPOSITE

feature
	make(l: EXPRESSION; r: EXPRESSION)
	do
		left := l
		right := r
	end

feature
	accept(v: VISITOR)
		deferred
	end
end
