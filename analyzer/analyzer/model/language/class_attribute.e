note
	description: "Summary description for {CLASS_ATTRIBUTE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_ATTRIBUTE
create
	make
feature
	type: STRING
	name: STRING
feature
	make(new_type: STRING; new_name: STRING)
		do
			type := new_type;
			name := new_name
		end

end
