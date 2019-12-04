note
	description: "Summary description for {ERROR_CHECKER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

expanded class
	ERROR_CHECKER

inherit
	ANY
		redefine default_create
	end

feature{NONE}
	program_access: PROGRAM_ACCESS

	program: PROGRAM
		do
			result := program_access.program
		end
	etf: ETF_MODEL
		do
			result := etf_access.m
		end
	etf_access: ETF_MODEL_ACCESS
feature
	error_msg: STRING

feature
	default_create
		do
			create error_msg.make_empty
		end

feature --enquires

	specifying_assignment: BOOLEAN --is there an assignment currently being specified?
		local
			r: STRING --routine name
			c: STRING --class name
		do
			result := etf.ass /~ void
			if result then
				--an assignment being specifying
				r := etf.my_ass.routine.name
				c := etf.my_ass.routine.parent_class.name
				error_msg := "Error (An assignment instruction is currently being specified for routine " + r +"in class " + c + ")."
			else
				error_msg := "Error (An assignment instruction is not currently being specified)."
			end
		end

	class_exists(cn:STRING): BOOLEAN -- to check if the class contains the cn
		local
			temp_str: STRING
		do
			create temp_str.make_empty
			if program_access.contain_class (cn)
			then
				Result := True
				temp_str := "Error (" + cn + " is already an existing class name)."
				-- error_msg := temp_str
			else
				Result := False
			end
		end

	routine_exists(c: PROGRAM_CLASS; name: STRING): BOOLEAN
		do
			if
				program_access.contain_routine (c, name)
			then
				Result := True -- feature already exists
				-- error_msg := "Error (" + name + " is already an existing feature name in class " + c.name + ")"
			else
				Result := False -- feature doesn't exist
			end
		end

	name_clash(class_name:STRING; pars:ARRAY[TUPLE[name:STRING;type:STRING]])
		local
			temp_arr: ARRAY[STRING]

		do
			create temp_arr.make_empty
			    -- store all the clashed feature name
			across pars.lower |..| pars.upper is i
			loop
				if program_access.contain_class (pars[i].name) or pars[i].name ~ "INTEGER" or pars[i].name ~ "INTEGER"
				then
					temp_arr.force (pars[i].name, temp_arr.count+1)
				end

			end

			-- error_msg := "Error (Parameter names clash with existing classes: " + generate_string(temp_arr) + ")."
		end

	repeated_parameter(pars:ARRAY[TUPLE[name:STRING;type:STRING]]): BOOLEAN
		local
			temp_arr: ARRAY[STRING] -- temperely store the non-existing name
			temp_arr2:ARRAY[STRING] -- if name exists in temp_arr, then add to temp_arr2
			temp_string: STRING
		do
			create temp_arr.make_empty
			create temp_arr2.make_empty
			across pars.lower |..| pars.upper is j
				loop
			 		if (not temp_arr.has(pars[j].name))
			 		then
			 		temp_arr.force(pars[j].name, temp_arr.count+1)
			 	else
			 		temp_arr2.force(pars[j].name, temp_arr2.count+1)

			 	end

			end
			if temp_arr2.count ~ 0
			then
			 	Result := True
			end

		-- error_msg := "Error (Parameter names clash with existing classes: " + generate_string(temp_arr2)+ ")."


		end

	--does the parameter type doesn't exists?
	par_type_not_exist(pars:ARRAY[TUPLE[name:STRING;type:STRING]]): BOOLEAN
		local
			temp_arr: ARRAY[STRING]
			types: ARRAY[STRING]
		do
			result := false
			create types.make_empty
			across pars is t loop
				types.force (t.type, types.count + 1)
			end

			temp_arr := get_wrong_types(types)

			if temp_arr.count > 0 then
				Result := True
				error_msg := "Error (Parameter types do not refer to primitive types or existing classes: " + generate_string(temp_arr) + " )."
			end
		end

	-- return_type_error()


feature{NONE} -- helper features

    get_wrong_types(types: ARRAY[STRING]) : ARRAY[STRING]
		--return a list of wrong types, not bool int or any existing classes
		do
			create result.make_empty
			across types is t loop
				if not(program_access.contain_class (t) or t ~ "INTEGER" or t ~ "BOOLEAN") then
					result.force (t, result.count+1)
				end
			end
		end


    generate_string(arr: ARRAY[STRING]): STRING
          -- generate the list element as string
	    do
	    	create Result.make_empty
    		across arr is str loop
    			Result.append (str + ", ")
    		end
    		Result.remove_tail (2)
	    end


end
