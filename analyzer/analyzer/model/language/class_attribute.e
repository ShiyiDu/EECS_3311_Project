note
	description: "Summary description for {CLASS_ATTRIBUTE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_ATTRIBUTE
inherit
	ANY
		redefine out
	end
create
	make
feature
	type: STRING
	name: STRING
	parent_class: PROGRAM_CLASS
feature
	make(new_type: STRING; new_name: STRING; new_class: PROGRAM_CLASS)
		do
			type := new_type;
			name := new_name
			parent_class := new_class
		end

	accept(v: VISITOR)
		do
			v.visit_attribute (current)
		end

feature
	out:STRING
		do
			create result.make_from_string ("+ " + name + ": " + type)
		end
end
