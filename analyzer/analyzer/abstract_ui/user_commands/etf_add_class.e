note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ADD_CLASS
inherit
	ETF_ADD_CLASS_INTERFACE


create
	make

feature
	ec:ERROR_CHECKER

feature {NONE}
	pre_cond(cn: STRING): BOOLEAN
		do
			result := not checker.specifying_assignment
				and not checker.class_exists (cn)
		end

feature -- command
	add_class(cn: STRING)
		require else
			add_class_precond(cn)
    	do
    		if pre_cond(cn) then
    			model.add_class (cn)
    		else
				set_error
    		end
			-- perform some update on the model state

			etf_cmd_container.on_change.notify ([Current])
    	end

end
