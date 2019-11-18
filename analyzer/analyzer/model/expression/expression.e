note
	description: "Summary description for {EXPRESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EXPRESSION
feature --public features, they should not be changed
	accept(v: VISITOR)
		deferred
	end

end
