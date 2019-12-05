note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ADD_QUERY
inherit
	ETF_ADD_QUERY_INTERFACE
create
	make
feature {NONE}
	pre_cond(cn: STRING ; fn: STRING ; ps: ARRAY[TUPLE[pn: STRING; ft: STRING]] ; rt: STRING): BOOLEAN
		do
			result := not checker.specifying_assignment
				and checker.class_exists (cn)
				and not checker.feature_exists (cn, fn)
				and not checker.name_clash (cn, ps)
				and not checker.duplicated_parameter (ps)
				and not checker.par_type_not_exist (ps)
				and not checker.type_not_exist (rt)
		end
feature -- command
	add_query(cn: STRING ; fn: STRING ; ps: ARRAY[TUPLE[pn: STRING; pt: STRING]] ; rt: STRING)
		require else
			add_query_precond(cn, fn, ps, rt)
    	do
			-- perform some update on the model state
			if pre_cond(cn, fn, ps, rt) then
				model.add_query (cn, fn, ps, rt)
			else
				set_error
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
