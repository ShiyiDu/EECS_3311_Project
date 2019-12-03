note
	description: "Summary description for {ERROR_CHECKER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

expanded class
	ERROR_CHECKER
--create
--	make


--feature
--	make
--		do
--			create error_msg.make_empty

--		end

feature{NONE}
	program_access: PROGRAM_ACCESS

	program: PROGRAM
		do
			result := program_access.program
		end
--    error_msg: STRING


feature --enquires

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

	not_been_assigned(ass: ROUTINE_ASSIGNMENT): BOOLEAN
		do
			if ass ~ void  -- not been assigned
			then
				Result := True
				-- error_msg := "Error (An assignment instruction is not currently being specified)."
			else
				Result := False  -- not yet complete assignment, how to get the class name and feature name
				-- error_msg := "Error (An assignment instruction is currently being specified for routine "
				--             + ass.name
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

	type_error(pars:ARRAY[TUPLE[name:STRING;type:STRING]]): BOOLEAN
	local
		temp_array: ARRAY[STRING]
		do
			create temp_array.make_from_array (wrong_type(pars))
			if temp_array.count /~ 0 then
				Result := True
				error_msg := "Error (Parameter types do not refer to primitive types or existing classes: " + generate_string(temp_arr) + " )."

			end
		end

	-- return_type_error()











feature -- generate repeated string

    wrong_type(pars:ARRAY[TUPLE[name:STRING;type:STRING]]):ARRAY[STRING]

    local
			temp_arr: ARRAY[STRING]

		do
			create temp_arr.make_empty
		    -- store all the clashed feature name
			across pars.lower |..| pars.upper is i
			loop
				if not(program_access.contain_class (pars[i].name) or pars[i].name ~ "INTEGER" or pars[i].name ~ "INTEGER")
				then
				temp_arr.force (pars[i].name, temp_arr.count+1)
				end

			end

		 error_msg := "Error (Parameter types do not refer to primitive types or existing classes: " + generate_string(temp_arr) + " )."
		end


    generate_string(arr: ARRAY[STRING]): STRING
          -- generate the list element as string
    do
    	create Result.make_empty
    	if
    		arr.count /~ 0  -- if the array is not empty
    	then
    		across arr.lower |..| (arr.upper-1) is i
    		loop
    			Result := Result + arr[i] + ", "
    		end
    		Result := Result + arr[arr.count]
    	end
    end


end
