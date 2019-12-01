note
	description: "Summary description for {ERROR_CHECKER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

expanded class
	ERROR_CHECKER


feature{NONE}
	program_access: PROGRAM_ACCESS

	program: PROGRAM
		do
			result := program_access.program
		end

feature -- Attributes
	error_msg: STRING

feature --enquires
	class_exists(name: STRING): BOOLEAN
		-- return true if the class name has already be in a file
		do
			if contain_class(name)
			then
				Result := True -- class does exist

			else
				Result := False -- class does not exist
			end
		end

	routine_exists(c: PROGRAM_CLASS; name: STRING): BOOLEAN
		do
			if
				contain_routine(c, name)
			then
				Result := True -- feature already exists
			else
				Result := False -- feature doesn't exist
			end
		end

	name_clash(class_name:STRING; pars:ARRAY[TUPLE[name:STRING;type:STRING]])
		local
			temp_arr: ARRAY[STRING]

		do
			create temp_arr.make_empty
			across pars as para
			loop
				if contain_class(para.name)
				then
					temp_arr.force(para.name, temp_arr.count+1)
				end
			end

			error_msg := "Error (Parameter names clash with existing classes: " + generate_string(temp_array) + ")."
		end

	repeated_parameter(pars:ARRAY[TUPLE[name:STRING;type:STRING]])
	local
		temp_arr: ARRAY[STRING] -- temperely store the non-existing name
		temp_arr2:ARRAY[STRING] -- if name exists in temp_arr, then add to temp_arr2
		temp_string: STRING
	do
		create temp_arr.make_empty
		create temp_arr2.make_empty
		across pars as para
		loop
			 if (not temp_arr.has(para.name))
			 then
			 	temp_arr.force(para.name, temp_arr.count+1)
			 else
			 	temp_arr2.force(para.name, temp_arr2.count+1)
			 end
		end

		error_msg := "Error (Parameter names clash with existing classes: " + generate_string(temp_arr2)+ ")."


	end

--	unknown_type()

feature -- generate repeated string
    generate_string(arr: ARRAY[STRING]): STRING
          -- generate the list element as string
    do
    	if
    		arr.count /~ 0  -- if the array is not empty
    	then
    		across arr.lower |..| (arr.upper-1) is i
    		loop
    			Result := Result + arr[i] + ", "
    		end
    		Result := Result + arr[count]
    	end
    end










end
