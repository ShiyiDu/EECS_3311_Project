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
	error_msg: STRING --these are only potential error messages, having one doesn't necessarily mean an error

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
		do
			if program_access.contain_class (cn)
			then
				Result := True
				error_msg := "Error (" + cn + " is already an existing class name)."
			else
				error_msg := "Error (" + cn + " is not an existing class name)."
				Result := False
			end
		end

	name_clash(class_name:STRING; pars:ARRAY[TUPLE[name:STRING;type:STRING]]): BOOLEAN
		local
			clashes: ARRAY[STRING]
		do
			create clashes.make_empty
			    -- store all the clashed feature name
			across pars is tup loop
				if program_access.contain_class (tup.name) or tup.name ~ "INTEGER" or tup.name ~ "BOOLEAN"
				then
					clashes.force (tup.name, clashes.count + 1)
				end
			end

			result := clashes.count > 0

			error_msg := "Error (Parameter names clash with existing classes: " + generate_string(clashes) + ")."
		end

	duplicated_parameter(pars:ARRAY[TUPLE[name:STRING;type:STRING]]): BOOLEAN
		local
			name_appeared: ARRAY[STRING] -- all the names appeared so far
			duplicates:ARRAY[STRING] -- the duplicated name
		do
			create name_appeared.make_empty
			name_appeared.compare_objects
			create duplicates.make_empty
			duplicates.compare_objects

			across pars is tup loop
				if name_appeared.has (tup.name) then
					if not duplicates.has (tup.name) then
						duplicates.force (tup.name, duplicates.count + 1)
					end
				end
				name_appeared.force (tup.name, name_appeared.count + 1)
			end

			if duplicates.count /~ 0 then
			 	Result := True
			 	error_msg := "Error (Parameter names clash with existing classes: " + generate_string(duplicates)+ ")."
			else
				Result := false
			end

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

	type_not_exist(name: STRING): BOOLEAN
		do
			if not(program_access.contain_class (name) or name ~ "INTEGER" or name ~ "BOOLEAN") then
				result := true
				error_msg := "Error (Return type does not refer to a primitive type or an existing class: " + name + ")."
			else
				result := false
			end
		end

	feature_exists(class_name: STRING; feature_name: STRING): BOOLEAN
		require
		 	class_exist: class_exists(class_name)
		local
			c: PROGRAM_CLASS
		do
			c := program_access.get_class (class_name)

			if
				program_access.contain_routine (c, feature_name)
				or program_access.contain_attribute (c, feature_name)
			then
				Result := True -- feature already exists
				error_msg := "Error (" + feature_name + " is already an existing feature name in class " + class_name + ")."
			else
				Result := False -- feature doesn't exist
				error_msg := "Error (" + feature_name + " is not an existing feature name in class " + class_name + ")."
			end
		end

--	feature_not_exist(class_name: STRING; feature_name: STRING): BOOLEAN
--		local
--			c: PROGRAM_CLASS
--		do
--			c := program_access.get_class (class_name)
--			if program_access.contain_routine (c, feature_name) then
--				result := false
--			else
--				result := true
--				error_msg := "Error (" + feature_name + " is not an existing feature name in class " + class_name + ")."
--			end
--		end

	feature_is_attribute(class_name: STRING; feature_name: STRING): BOOLEAN
		local
			c: PROGRAM_CLASS
		do
			result := false
			c := program_access.get_class (class_name)
			if program_access.contain_attribute (c, feature_name) then
				result := true
				error_msg := "Error (Attribute " + feature_name + " in class " + class_name + " cannot be specified with an implementation)."
			end
		end

	empty_call_chain(chain: ARRAY[STRING]): BOOLEAN
		do
			result := chain.is_empty
			error_msg := "Error (Call chain is empty)."
		end


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
