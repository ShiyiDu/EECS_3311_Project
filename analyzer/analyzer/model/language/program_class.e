note
	description: "Summary description for {PROGRAM_CLASS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROGRAM_CLASS
inherit
	ANY redefine out end
create
	make
feature
	name: STRING
	--how do I preserve the order?
	sequence: ARRAY[TUPLE[is_att:BOOLEAN; att:detachable CLASS_ATTRIBUTE; rou:detachable CLASS_ROUTINE]]

	attributes: ARRAY[CLASS_ATTRIBUTE]
	queries: ARRAY[ROUTINE_QUERY]
	commands: ARRAY[ROUTINE_COMMAND]
	program: PROGRAM -- the program that contains this class
	program_access: PROGRAM_ACCESS
feature
	make(new_name:STRING)
		do
			name := new_name
			program := program_access.program

			create sequence.make_empty
			create queries.make_empty
			create attributes.make_empty
			create commands.make_empty
		end

	routines: ARRAY[CLASS_ROUTINE]
		do
			create result.make_empty
			across queries is q loop
				result.force(q, result.count+1)
			end
			across commands is c loop
				result.force (c, result.count+1)
			end
		end
	add_attribute(new_attribute: CLASS_ATTRIBUTE)
		local
			seq: TUPLE[b:BOOLEAN; a:detachable CLASS_ATTRIBUTE; c:detachable CLASS_ROUTINE]
		do
			attributes.force(new_attribute, attributes.count + 1)
			seq := [true, new_attribute, void]
			sequence.force (seq, sequence.count+1)
		end

	add_query(new_routine: ROUTINE_QUERY)
		local
			seq: TUPLE[b:BOOLEAN; a:detachable CLASS_ATTRIBUTE; c:detachable CLASS_ROUTINE]
		do
			queries.force (new_routine, queries.count + 1)
			seq := [false, void, new_routine]
			sequence.force (seq, sequence.count+1)
		end

	add_command(new_routine: ROUTINE_COMMAND)
		local
			seq: TUPLE[b:BOOLEAN; a:detachable CLASS_ATTRIBUTE; c:detachable CLASS_ROUTINE]
		do
			commands.force(new_routine, commands.count + 1)
			seq := [false, void, new_routine]
			sequence.force (seq, sequence.count+1)
		end

	accept(v:VISITOR)
		do
			v.visit_class (current)
		end

	out: STRING
		do
			create result.make_from_string("    " + name)
			result.append ("%N      Number of attributes: " + attributes.count.out)
			across attributes is att loop
				result.append ("%N        " + att.out)
			end
			result.append ("%N      Number of queries: " + queries.count.out)
			across queries is q loop
				result.append ("%N        " + q.out)
			end
			result.append ("%N      Number of commands: " + commands.count.out)
			across commands is c loop
				result.append ("%N        " + c.out)
			end
		end

end
