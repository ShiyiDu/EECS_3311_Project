note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ADD_COMMAND
inherit
	ETF_ADD_COMMAND_INTERFACE
create
	make

feature {NONE}
	pre_cond(cn: STRING ; fn: STRING ; ps: ARRAY[TUPLE[pn: STRING; ft: STRING]]): BOOLEAN
		do
			result := not checker.specifying_assignment
				and checker.class_exists (cn)
				and not checker.feature_exists (cn, fn)
				and not checker.name_clash (cn, ps)
				and not checker.duplicated_parameter (ps)
				and not checker.par_type_not_exist (ps)
		end

feature -- command
	add_command(cn: STRING ; fn: STRING ; ps: ARRAY[TUPLE[pn: STRING; ft: STRING]])
		require else
			add_command_precond(cn, fn, ps)
    	do
			-- perform some update on the model state
			if pre_cond(cn, fn, ps) then
				model.add_command (cn, fn, ps)
			else
				set_error
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
