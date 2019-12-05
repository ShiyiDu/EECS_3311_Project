note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ADD_ATTRIBUTE
inherit
	ETF_ADD_ATTRIBUTE_INTERFACE
create
	make

feature {NONE}
	pre_cond(cn: STRING; fn: STRING; ft:STRING): BOOLEAN
		do
			result :=
				not checker.specifying_assignment
				and checker.class_exists (cn)
				and not checker.feature_exists (cn, fn)
				and not checker.type_not_exist (ft)
		end

feature -- command
	add_attribute(cn: STRING ; fn: STRING ; ft: STRING)
		require else
			add_attribute_precond(cn, fn, ft)
    	do
			-- perform some update on the model state
			if pre_cond(cn, fn, ft) then
				model.add_attribute (cn, fn, ft)
			else
				set_error
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
