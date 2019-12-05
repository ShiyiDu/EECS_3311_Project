note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ADD_ASSIGNMENT_INSTRUCTION
inherit
	ETF_ADD_ASSIGNMENT_INSTRUCTION_INTERFACE
create
	make

feature {NONE}
	pre_cond(cn: STRING; fn: STRING; n:STRING): BOOLEAN
		do
			result :=
				not checker.specifying_assignment
				and checker.class_exists (cn)
				and checker.feature_exists (cn, fn)
				and not checker.feature_is_attribute (cn, fn)
		end

feature -- command
	add_assignment_instruction(cn: STRING ; fn: STRING ; n: STRING)
		require else
			add_assignment_instruction_precond(cn, fn, n)
    	do
			-- perform some update on the model state
			if pre_cond(cn, fn, n) then
				model.add_assignment_instruction (cn, fn, n)
			else
				set_error
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
