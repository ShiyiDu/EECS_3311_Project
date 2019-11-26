note
	description: "Summary description for {PROGRAM_CLASS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROGRAM_CLASS
create
	make
feature
	name: STRING
	attributes: ARRAY[CLASS_ATTRIBUTE]
	routines: ARRAY[CLASS_ROUTINE]
feature
	make(new_name:STRING)
		do
			name := new_name
			create attributes.make_empty
			create routines.make_empty
		end
	add_attribute(new_attribute: CLASS_ATTRIBUTE)
		do
			attributes.force(new_attribute, attributes.count + 1)
		end

	add_routine(new_routine: CLASS_ROUTINE)
		do
			routines.force (new_routine, routines.count + 1)
		end

	accept(v:VISITOR)
		do
			v.visit_class (current)
		end


end
