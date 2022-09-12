######### TOMASULO ALGORITHM IMPLEMENTATION


FP_adder_time = 4
FP_multiplier_time = 6
INT_adder_time = 2
INT_multiplier_time = 5
INT_logic_unit_time = 2
memory_access_time = 2




#### Function for obtaining all the indices where the search element is present in the list
def getIndexPositions(listOfElements, element):
    indexPosList = []
    for i in range(len(listOfElements)): 
        if listOfElements[i] == element:
            indexPosList.append(i)
    return(indexPosList)



#### 2 floating point adder/ subtractor functions
def FP_adder_1(a, b, enable):											# enable = 0 for addition, enable = 1 for subtraction							
	if(enable == 0):
		return(a+b)
	else:
		return(a-b)


def FP_adder_2(a, b, enable):											# enable = 0 for addition, enable = 1 for subtraction							
	if(enable == 0):
		return(a+b)
	else:
		return(a-b)



#### 2 floating point multiplication functions
def FP_multiplier_1(a, b):
	return(round(a*b, 6))


def FP_multiplier_2(a, b):
	return(round(a*b, 6))



#### 2 integer adder/ subtractor functions
def INT_adder_1(a, b, c, enable):										# enable = 0 for addition, enable = 1 for subtraction							
	a1 = int(a)
	b1 = int(b)
	c1 = int(c)
	if(enable == 0):
		return(a1+b1+c1)
	else:
		return(a1-b1-c1)


def INT_adder_2(a, b, c, enable):										# enable = 0 for addition, enable = 1 for subtraction							
	a1 = int(a)
	b1 = int(b)
	c1 = int(c)
	if(enable == 0):
		return(a1+b1+c1)
	else:
		return(a1-b1-c1)



#### 2 integer multiplication functions
def INT_multiplier_1(a, b):
	a1 = int(a)
	b1 = int(b)
	return(a1*b1)


def INT_multiplier_2(a, b):
	a1 = int(a)
	b1 = int(b)
	return(a1*b1)



#### 2 integer logic unit functions 
def INT_logic_unit_1(a, b, enable):  
	if(enable == 0):													# complement of a
		return(int(bin(~a).replace("0b", ""), 2))
	elif(enable == 1):													# bitwise XOR
		return(int(bin(a^b).replace("0b", ""), 2))
	elif(enable == 2):													# bitwise NAND
		return(int(bin(~(a&b)).replace("0b", ""), 2))
	elif(enable == 3):													# shift right	
		return(int(bin(a>>b).replace("0b", ""), 2))
	else:																# shift left	
		return(int(bin(a<<b).replace("0b", ""), 2))	


def INT_logic_unit_2(a, b, enable):  
	if(enable == 0):													# complement of a
		return(int(bin(~a).replace("0b", ""), 2))
	elif(enable == 1):													# bitwise XOR
		return(int(bin(a^b).replace("0b", ""), 2))
	elif(enable == 2):													# bitwise NAND
		return(int(bin(~(a&b)).replace("0b", ""), 2))
	elif(enable == 3):													# shift right	
		return(int(bin(a>>b).replace("0b", ""), 2))
	else:																# shift left	
		return(int(bin(a<<b).replace("0b", ""), 2))	



#### 2 memory access functions( load/ store)
def memory_access_1(a):										
	return(a)


def memory_access_2(a):										
	return(a)




#### Read the input instructions from the file
instructions_file = open("instructions.txt")							# open the file where the instructions are present
ins_data = instructions_file.read()										# read the contents of the file
instructions_file.close()												# close the file after reading the contents
instructions = ins_data.split(";\n")									# split the contents of the file to different instructions

instructions1 = []														# list to save the segments of an instruction in 'instructions'
check = []																# to check if an instruction has entered the resevation station
for i in instructions:
	if(i != ''):														# don't consider an empty instructions
		i0 = i.replace(";", "")
		i1 = i0.replace(" ", ",")										# replace " " with "," such that it is easier to get the different segments of the instruction 
		ins = i1.split(",")												# split the above with "," such that we get the different segments of the instruction
		instructions1.append([i for i in ins if i])						# remove the empty strings from the list
		check.append(0)
print("instructions1 : ", instructions1)



#### Initializing the reservation stations( the number of reservation stations is 5)
reservation_stations = {}												# using dictionary to represent the reservation stations
reservation_stations['name'] = ['', '', '', '', '']						# 'name' = name of the operation
reservation_stations['op'] = ['', '', '', '', '']						# 'op' = operation
reservation_stations['Qj'] = [-1, -1, -1, -1, -1]							# 'Qj' = represents the reservation station that will produce the corresponding source operand, '-1' represents that the source operand is already avaliable
reservation_stations['Qk'] = [-1, -1, -1, -1, -1]							# 'Qk' = represents the reservation station that will produce the corresponding source operand, '-1' represents that the source operand is already avaliable
reservation_stations['Vj'] = ['', '', '', '', '']						# 'Vj' = represents the value of the source operand
reservation_stations['Vk'] = ['', '', '', '', '']						# 'Vk' = represents the value of the source operand, used for holding offset in case of load
reservation_stations['A'] = ['', '', '', '', '']						# 'A' = holds information for memory address calculation for load or store; initially the immediate field of the instruction is stored here; after the address calculation, the effective address is stored here 
reservation_stations['busy'] = [0, 0, 0, 0, 0]							# 'busy' = indicates that this resevation station and it's accompanying functional unit are occupied; 0 - free, 1 - occupied 
reservation_stations['id'] = [-1, -1, -1, -1, -1]
print("reservation_stations : ", reservation_stations)



#### Filling the reservation stations												
load_buffer = []
load_buffer_name = []
load_buffer_id = []
store_buffer = []
store_buffer_name = []
store_buffer_id = []

working = [0, 0, 0, 0, 0]

clk_fp_adder_1 = -1
clk_fp_adder_2 = -1
clk_fp_multiplier_1 = -1
clk_fp_multiplier_2 = -1
clk_int_adder_1 = -1
clk_int_adder_2 = -1
clk_int_multiplier_1 = -1
clk_int_multiplier_2 = -1
clk_int_logic_unit_1 = -1
clk_int_logic_unit_2 = -1
clk_mem_access_1 = -1
clk_mem_access_2 = -1

flag_fp_adder_1 = 0
flag_fp_adder_2 = 0
flag_fp_multiplier_1 = 0
flag_fp_multiplier_2 = 0
flag_int_adder_1 = 0
flag_int_adder_2 = 0
flag_int_multiplier_1 = 0
flag_int_multiplier_2 = 0
flag_int_logic_unit_1 = 0
flag_int_logic_unit_2 = 0
flag_mem_access_1 = 0
flag_mem_access_2 = 0



registers = [3, 1, 4, 2, 2, 0, 1, 1.23, 2, 5, 6, 3, 0, 1, 7, 0]
print("reg : ", registers)

qi = {'R0': [], 'R1': [], 'R2': [], 'R3': [], 'R4': [], 'R5': [], 'R6': [], 'R7': [], 'R8': [], 'R9': [], 'R10': [], 'R11': [], 'R12': [], 'R13': [], 'R14': [], 'R15': []}


main_memory = [0 for x in range(256)]
main_memory[0] = 6
main_memory[4] = 9
print("main memory : ", main_memory)



i = 0
clock = 0


while(((0 in check) or (1 in reservation_stations['busy']))):																										
	
	if(0 in reservation_stations['busy'] and (0 in check)):
		check[i] = 1
		free = reservation_stations['busy'].index(0)
		reservation_stations['op'][free] = instructions1[i][0]																		
		reservation_stations['busy'][free] = 1																						
		reservation_stations['id'][free] = i


		if(reservation_stations['op'][free] == 'FADD' or reservation_stations['op'][free] == 'FSUB'):
			if(flag_fp_adder_1 == 0):																										# we give the 'name' of the reservation station only any of the units are free
				reservation_stations['name'][free] = reservation_stations['op'][free] + str(1)
				flag_fp_adder_1 = 1							
			elif(flag_fp_adder_2 == 0):
				reservation_stations['name'][free] = reservation_stations['op'][free] + str(2)
				flag_fp_adder_2 = 1							
				
			if(qi[instructions1[i][2]] != []):
				reservation_stations['Qj'][free] = qi[instructions1[i][2]][-1]
				reservation_stations['Vj'][free] = ''
			else:
				reservation_stations['Qj'][free] = -1
				reservation_stations['Vj'][free] = registers[int(instructions1[i][2][1:])]

			if(qi[instructions1[i][3]] != []):
				reservation_stations['Qk'][free] = qi[instructions1[i][3]][-1]
				reservation_stations['Vk'][free] = ''
			else:
				reservation_stations['Qk'][free] = -1
				reservation_stations['Vk'][free] = registers[int(instructions1[i][3][1:])]

			reservation_stations['A'][free] = ''

			if(reservation_stations['name'][free] == ''):
				qi[instructions1[i][1]].append(reservation_stations['id'][free])
			else:
				qi[instructions1[i][1]].append(reservation_stations['name'][free])


		if(reservation_stations['op'][free] == 'FMUL'):
			if(flag_fp_multiplier_1 == 0):																										
				reservation_stations['name'][free] = reservation_stations['op'][free] + str(1)
				flag_fp_multiplier_1 = 1							
			elif(flag_fp_multiplier_2 == 0):
				reservation_stations['name'][free] = reservation_stations['op'][free] + str(2)
				flag_fp_multiplier_2 = 1								
				
			if(qi[instructions1[i][2]] != []):
				reservation_stations['Qj'][free] = qi[instructions1[i][2]][-1]
				reservation_stations['Vj'][free] = ''
			else:
				reservation_stations['Qj'][free] = -1
				reservation_stations['Vj'][free] = registers[int(instructions1[i][2][1:])]

			if(qi[instructions1[i][3]] != []):
				reservation_stations['Qk'][free] = qi[instructions1[i][3]][-1]
				reservation_stations['Vk'][free] = ''
			else:
				reservation_stations['Qk'][free] = -1
				reservation_stations['Vk'][free] = registers[int(instructions1[i][3][1:])]

			reservation_stations['A'][free] = ''

			if(reservation_stations['name'][free] == ''):
				qi[instructions1[i][1]].append(reservation_stations['id'][free])
			else:
				qi[instructions1[i][1]].append(reservation_stations['name'][free])
		

		if(reservation_stations['op'][free] == 'ADD' or reservation_stations['op'][free] == 'SUB' or reservation_stations['op'][free] == 'ADDC' or reservation_stations['op'][free] == 'SBB'):
			if(flag_int_adder_1 == 0):																										
				reservation_stations['name'][free] = reservation_stations['op'][free] + str(1)
				flag_int_adder_1 = 1							
			elif(flag_int_adder_2 == 0):
				reservation_stations['name'][free] = reservation_stations['op'][free] + str(2)
				flag_int_adder_2 = 1									
				
			if(qi[instructions1[i][2]] != []):
				reservation_stations['Qj'][free] = qi[instructions1[i][2]][-1]
				reservation_stations['Vj'][free] = ''
			else:
				reservation_stations['Qj'][free] = -1
				reservation_stations['Vj'][free] = registers[int(instructions1[i][2][1:])]

			if(qi[instructions1[i][3]] != []):
				reservation_stations['Qk'][free] = qi[instructions1[i][3]][-1]
				reservation_stations['Vk'][free] = ''
			else:
				reservation_stations['Qk'][free] = -1
				reservation_stations['Vk'][free] = registers[int(instructions1[i][3][1:])]

			reservation_stations['A'][free] = ''

			if(reservation_stations['name'][free] == ''):
				qi[instructions1[i][1]].append(reservation_stations['id'][free])
			else:
				qi[instructions1[i][1]].append(reservation_stations['name'][free])


		if(reservation_stations['op'][free] == 'MUL'):
			if(flag_int_multiplier_1 == 0):																										
				reservation_stations['name'][free] = reservation_stations['op'][free] + str(1)
				flag_int_multiplier_1 = 1							
			elif(flag_int_multiplier_2 == 0):
				reservation_stations['name'][free] = reservation_stations['op'][free] + str(2)
				flag_int_multiplier_2 = 1								
				
			if(qi[instructions1[i][2]] != []):
				reservation_stations['Qj'][free] = qi[instructions1[i][2]][-1]
				reservation_stations['Vj'][free] = ''
			else:
				reservation_stations['Qj'][free] = -1
				reservation_stations['Vj'][free] = registers[int(instructions1[i][2][1:])]

			if(qi[instructions1[i][3]] != []):
				reservation_stations['Qk'][free] = qi[instructions1[i][3]][-1]
				reservation_stations['Vk'][free] = ''
			else:
				reservation_stations['Qk'][free] = -1
				reservation_stations['Vk'][free] = registers[int(instructions1[i][3][1:])]

			reservation_stations['A'][free] = ''

			if(reservation_stations['name'][free] == ''):
				qi[instructions1[i][1]].append(reservation_stations['id'][free])
			else:
				qi[instructions1[i][1]].append(reservation_stations['name'][free])
		

		if(reservation_stations['op'][free] == 'CMP' or reservation_stations['op'][free] == 'XOR' or reservation_stations['op'][free] == 'NAND' or reservation_stations['op'][free] == 'SHR' or reservation_stations['op'][free] == 'LHR'):
			if(flag_int_logic_unit_1 == 0):																										
				reservation_stations['name'][free] = reservation_stations['op'][free] + str(1)
				flag_int_logic_unit_1 = 1							
			elif(flag_int_logic_unit_2 == 0):
				reservation_stations['name'][free] = reservation_stations['op'][free] + str(2)
				flag_int_logic_unit_2 = 1

			if(reservation_stations['op'][free] == 'CMP'):									
				if(qi[instructions1[i][1]] != []):
					reservation_stations['Qj'][free] = qi[instructions1[i][1]][-1]
					reservation_stations['Vj'][free] = ''
				else:
					reservation_stations['Qj'][free] = -1
					reservation_stations['Vj'][free] = registers[int(instructions1[i][1][1:])]
				
				reservation_stations['Qk'][free] = -1
				reservation_stations['Vk'][free] = ''

				reservation_stations['A'][free] = ''

			else:
				if(qi[instructions1[i][2]] != []):
					reservation_stations['Qj'][free] = qi[instructions1[i][2]][-1]
					reservation_stations['Vj'][free] = ''
				else:
					reservation_stations['Qj'][free] = -1
					reservation_stations['Vj'][free] = registers[int(instructions1[i][2][1:])]

				if(qi[instructions1[i][3]] != []):
					reservation_stations['Qk'][free] = qi[instructions1[i][3]][-1]
					reservation_stations['Vk'][free] = ''
				else:
					reservation_stations['Qk'][free] = -1
					reservation_stations['Vk'][free] = registers[int(instructions1[i][3][1:])]

			reservation_stations['A'][free] = ''

			if(reservation_stations['name'][free] == ''):
				qi[instructions1[i][1]].append(reservation_stations['id'][free])
			else:
				qi[instructions1[i][1]].append(reservation_stations['name'][free])
		

		if(reservation_stations['op'][free] == 'LDR' or reservation_stations['op'][free] == 'STR'):
			if(flag_mem_access_1 == 0):	
				reservation_stations['name'][free] = reservation_stations['op'][free] + str(1)
				flag_mem_access_1 = 1							
			elif(flag_mem_access_2 == 0):
				reservation_stations['name'][free] = reservation_stations['op'][free] + str(2)
				flag_mem_access_2 = 1							
				
			reservation_stations['A'][free] = int(instructions1[i][2])

			reservation_stations['Qj'][free] = -1
			reservation_stations['Vj'][free] = ''

			if(reservation_stations['op'][free] == 'LDR'):
				if(reservation_stations['A'][free] in store_buffer):
					a = store_buffer_id[getIndexPositions(store_buffer, reservation_stations['A'][free])[-1]]
				else:
					a = 0
				
				if(qi[instructions1[i][1]] != []):
					if(str(qi[instructions1[i][1]][-1]).isdigit()):
						b = qi[instructions1[i][1]][-1]
					else:
						b = reservation_stations['id'][reservation_stations['name'].index(qi[instructions1[i][1]][-1])]

						if(a <= b):
							if(reservation_stations['name'][reservation_stations['id'].index(b)] != ''):
								reservation_stations['Qk'][free] = reservation_stations['name'][reservation_stations['id'].index(b)]
							else:
								reservation_stations['Qk'][free] = b
							reservation_stations['Vk'][free] = ''
						else:
							if(reservation_stations['name'][reservation_stations['id'].index(a)] != ''):
								reservation_stations['Qk'][free] = reservation_stations['name'][reservation_stations['id'].index(a)]
							else:
								reservation_stations['Qk'][free] = a
							reservation_stations['Vk'][free] = ''

				elif(reservation_stations['A'][free] in store_buffer):
					reservation_stations['Qk'][free] = store_buffer_id[getIndexPositions(store_buffer, reservation_stations['A'][free])[-1]]
					reservation_stations['Vk'][free] = ''

				else:
					reservation_stations['Qk'][free] = -1
					reservation_stations['Vk'][free] = registers[int(instructions1[i][1][1:])]

				load_buffer.append(int(instructions1[i][2]))
				load_buffer_id.append(reservation_stations['id'][free])
				load_buffer_name.append(reservation_stations['name'][free])

			else:
				if(reservation_stations['A'][free] in store_buffer):
					a = store_buffer_id[getIndexPositions(store_buffer, reservation_stations['A'][free])[-1]]
				else:
					a = 0

				if(reservation_stations['A'][free] in load_buffer):
					b = load_buffer_id[getIndexPositions(load_buffer, reservation_stations['A'][free])[-1]]
				else:
					b = 0
				
				if(qi[instructions1[i][1]] != []):
					if(str(qi[instructions1[i][1]][-1]).isdigit()):
						c = qi[instructions1[i][1]][-1]
					else:
						c = reservation_stations['id'][reservation_stations['name'].index(qi[instructions1[i][1]][-1])]

					abc = [a, b, c]
					if(a == max(abc)):
						if(reservation_stations['name'][reservation_stations['id'].index(a)] != ''):
							reservation_stations['Qk'][free] = reservation_stations['name'][reservation_stations['id'].index(a)]
						else:
							reservation_stations['Qk'][free] = a
						reservation_stations['Vk'][free] = ''
					elif(b == max(abc)):
						if(reservation_stations['name'][reservation_stations['id'].index(b)] != ''):
							reservation_stations['Qk'][free] = reservation_stations['name'][reservation_stations['id'].index(b)]
						else:
							reservation_stations['Qk'][free] = b
						reservation_stations['Vk'][free] = ''
					else:
						if(reservation_stations['name'][reservation_stations['id'].index(c)] != ''):
							reservation_stations['Qk'][free] = reservation_stations['name'][reservation_stations['id'].index(c)]
						else:
							reservation_stations['Qk'][free] = c
						reservation_stations['Vk'][free] = ''

				elif(reservation_stations['A'][free] in store_buffer and reservation_stations['A'][free] in load_buffer):
					a = store_buffer_id[getIndexPositions(store_buffer, reservation_stations['A'][free])[-1]]
					b = load_buffer_id[getIndexPositions(load_buffer, reservation_stations['A'][free])[-1]]
					if(a <= b):
						if(reservation_stations['name'][reservation_stations['id'].index(b)] != ''):
							reservation_stations['Qk'][free] = reservation_stations['name'][reservation_stations['id'].index(b)]
						else:
							reservation_stations['Qk'][free] = b
						reservation_stations['Vk'][free] = ''
					else:
						if(reservation_stations['name'][reservation_stations['id'].index(a)] != ''):
							reservation_stations['Qk'][free] = reservation_stations['name'][reservation_stations['id'].index(a)]
						else:
							reservation_stations['Qk'][free] = a
						reservation_stations['Vk'][free] = ''
				elif(reservation_stations['A'][free] in store_buffer):
					reservation_stations['Qk'][free] = store_buffer_id[getIndexPositions(store_buffer, reservation_stations['A'][free])[-1]]
					reservation_stations['Vk'][free] = ''
				elif(reservation_stations['A'][free] in load_buffer):
					reservation_stations['Qk'][free] = load_buffer_id[getIndexPositions(load_buffer, reservation_stations['A'][free])[-1]]
					reservation_stations['Vk'][free] = ''		
				else:
					reservation_stations['Qk'][free] = -1
					reservation_stations['Vk'][free] = registers[int(instructions1[i][1][1:])]		

				store_buffer.append(int(instructions1[i][2]))
				store_buffer_id.append(reservation_stations['id'][free])
				store_buffer_name.append(reservation_stations['name'][free])

			if(reservation_stations['name'][free] == ''):
				qi[instructions1[i][1]].append(reservation_stations['id'][free])
			else:
				qi[instructions1[i][1]].append(reservation_stations['name'][free])


		if(reservation_stations['op'][free] == 'HLT'):
			reservation_stations['name'][free] = 'HLT'							
			reservation_stations['Qj'][free] = -1
			reservation_stations['Qk'][free] = -1
			reservation_stations['Vj'][free] = ''
			reservation_stations['Vk'][free] = ''
			reservation_stations['A'][free] = ''
		
		
		i = i + 1		


	

	for k in range(0, 5):
		if(working[k] == 0):
			if(reservation_stations['Qj'][k] == -1 and reservation_stations['Qk'][k] == -1 and reservation_stations['name'][k] != ''):
				working[k] = 1 

				if(reservation_stations['op'][k] == 'FADD' or reservation_stations['op'][k] == 'FSUB'):
					t = int(reservation_stations['name'][k][-1])
					if(t == 1):
						clk_fp_adder_1 = clock + FP_adder_time
						p_fp_adder_1 = k
						if(reservation_stations['op'][k] == 'FADD'):
							res_fp_adder_1 = FP_adder_1(reservation_stations['Vj'][k], reservation_stations['Vk'][k], 0)
						if(reservation_stations['op'][k] == 'FSUB'):
							res_fp_adder_1 = FP_adder_1(reservation_stations['Vj'][k], reservation_stations['Vk'][k], 1)

					if(t == 2):
						clk_fp_adder_2 = clock + FP_adder_time
						p_fp_adder_2 = k
						if(reservation_stations['op'][k] == 'FADD'):
							res_fp_adder_2 = FP_adder_2(reservation_stations['Vj'][k], reservation_stations['Vk'][k], 0)
						if(reservation_stations['op'][k] == 'FSUB'):
							res_fp_adder_2 = FP_adder_2(reservation_stations['Vj'][k], reservation_stations['Vk'][k], 1)
						
						
				if(reservation_stations['op'][k] == 'FMUL'):
					t = int(reservation_stations['name'][k][-1])
					if(t == 1):
						clk_fp_multiplier_1 = clock + FP_multiplier_time
						p_fp_multiplier_1 = k
						res_fp_multiplier_1 = FP_multiplier_1(reservation_stations['Vj'][k], reservation_stations['Vk'][k])

					if(t == 2):
						clk_fp_multiplier_2 = clock + FP_multiplier_time
						p_fp_multiplier_2 = k
						res_fp_multiplier_2 = FP_multiplier_2(reservation_stations['Vj'][k], reservation_stations['Vk'][k])


				if(reservation_stations['op'][k] == 'ADD' or reservation_stations['op'][k] == 'ADDC' or reservation_stations['op'][k] == 'SUB' or reservation_stations['op'][k] == 'SBB'):
					t = int(reservation_stations['name'][k][-1])
					if(t == 1):
						clk_int_adder_1 = clock + INT_adder_time
						p_int_adder_1 = k
						if(reservation_stations['op'][k] == 'ADD'):
							res_int_adder_1 = INT_adder_1(reservation_stations['Vj'][k], reservation_stations['Vk'][k], 0, 0)
						if(reservation_stations['op'][k] == 'ADDC'):
							res_int_adder_1 = INT_adder_1(reservation_stations['Vj'][k], reservation_stations['Vk'][k], 1, 0)
						if(reservation_stations['op'][k] == 'SUB'):
							res_int_adder_1 = INT_adder_1(reservation_stations['Vj'][k], reservation_stations['Vk'][k], 0, 1)
						if(reservation_stations['op'][k] == 'SBB'):
							res_int_adder_1 = INT_adder_1(reservation_stations['Vj'][k], reservation_stations['Vk'][k], 1, 1)
					
					if(t == 2):
						clk_int_adder_2 = clock + INT_adder_time
						p_int_adder_2 = k
						if(reservation_stations['op'][k] == 'ADD'):
							res_int_adder_2 = INT_adder_2(reservation_stations['Vj'][k], reservation_stations['Vk'][k], 0, 0)
						if(reservation_stations['op'][k] == 'ADDC'):
							res_int_adder_2 = INT_adder_2(reservation_stations['Vj'][k], reservation_stations['Vk'][k], 1, 0)
						if(reservation_stations['op'][k] == 'SUB'):
							res_int_adder_2 = INT_adder_2(reservation_stations['Vj'][k], reservation_stations['Vk'][k], 0, 1)
						if(reservation_stations['op'][k] == 'SBB'):
							res_int_adder_2 = INT_adder_2(reservation_stations['Vj'][k], reservation_stations['Vk'][k], 1, 1)
					

				if(reservation_stations['op'][k] == 'MUL'):
					t = int(reservation_stations['name'][k][-1])
					if(t == 1):
						clk_int_multiplier_1 = clock + INT_multiplier_time
						p_int_multiplier_1 = k
						res_int_multiplier_1 = INT_multiplier_1(reservation_stations['Vj'][k], reservation_stations['Vk'][k])
						
					if(t == 2):
						clk_int_multiplier_2 = clock + INT_multiplier_time
						p_int_multiplier_2 = k
						res_int_multiplier_2 = INT_multiplier_2(reservation_stations['Vj'][k], reservation_stations['Vk'][k])
						

				if(reservation_stations['op'][k] == 'CMP' or reservation_stations['op'][k] == 'XOR' or reservation_stations['op'][k] == 'NAND' or reservation_stations['op'][k] == 'SHR' or reservation_stations['op'][k] == 'LHR'):
					t = int(reservation_stations['name'][k][-1])
					if(t == 1):
						clk_int_logic_unit_1 = clock + INT_logic_unit_time
						p_int_logic_unit_1 = k
						if(reservation_stations['op'][k] == 'CMP'):
							res_int_logic_unit_1 = INT_logic_unit_1(reservation_stations['Vj'][k], 0, 0)
						if(reservation_stations['op'][k] == 'XOR'):
							res_int_logic_unit_1 = INT_logic_unit_1(reservation_stations['Vj'][k], reservation_stations['Vk'][k], 1)
						if(reservation_stations['op'][k] == 'NAND'):
							res_int_logic_unit_1 = INT_logic_unit_1(reservation_stations['Vj'][k], reservation_stations['Vk'][k], 2)
						if(reservation_stations['op'][k] == 'SHR'):
							res_int_logic_unit_1 = INT_logic_unit_1(reservation_stations['Vj'][k], reservation_stations['Vk'][k], 3)
						if(reservation_stations['op'][k] == 'LHR'):
							res_int_logic_unit_1 = INT_logic_unit_1(reservation_stations['Vj'][k], reservation_stations['Vk'][k], 4)

					if(t == 2):
						clk_int_logic_unit_2 = clock + INT_logic_unit_time
						p_int_logic_unit_2 = k
						if(reservation_stations['op'][k] == 'CMP'):
							res_int_logic_unit_2 = INT_logic_unit_2(reservation_stations['Vj'][k], 0, 0)
						if(reservation_stations['op'][k] == 'XOR'):
							res_int_logic_unit_2 = INT_logic_unit_2(reservation_stations['Vj'][k], reservation_stations['Vk'][k], 1)
						if(reservation_stations['op'][k] == 'NAND'):
							res_int_logic_unit_2 = INT_logic_unit_2(reservation_stations['Vj'][k], reservation_stations['Vk'][k], 2)
						if(reservation_stations['op'][k] == 'SHR'):
							res_int_logic_unit_2 = INT_logic_unit_2(reservation_stations['Vj'][k], reservation_stations['Vk'][k], 3)
						if(reservation_stations['op'][k] == 'LHR'):
							res_int_logic_unit_2 = INT_logic_unit_2(reservation_stations['Vj'][k], reservation_stations['Vk'][k], 4)
					
					
				if(reservation_stations['op'][k] == 'LDR' or reservation_stations['op'][k] == 'STR'):
					t = int(reservation_stations['name'][k][-1])
					if(t == 1):
						if(reservation_stations['op'][k] == 'LDR'):
							if(reservation_stations['id'][k] in store_buffer_id):
								k1 = store_buffer[:store_buffer_ins.index(reservation_stations['id'][k])]
								if(reservation_stations['A'][k] not in k1):
									res_mem_access_1 = memory_access_1(reservation_stations['A'][k])
									clk_mem_access_1 = clock + memory_access_time
									p_mem_access_1 = k
							else:
								res_mem_access_1 = memory_access_1(reservation_stations['A'][k])
								clk_mem_access_1 = clock + memory_access_time
								p_mem_access_1 = k
						
						if(reservation_stations['op'][k] == 'STR'):
							k2 = []
							k3 = []
							if(reservation_stations['id'][k] in store_buffer_id):
								k2 = store_buffer[:store_buffer_id.index(reservation_stations['id'][k])]
							if(reservation_stations['id'][k] in load_buffer_id):
								k3 = load_buffer[:load_buffer_ins.index(reservation_stations['id'][k])]
							if((reservation_stations['A'][k] not in k2) and (reservation_stations['A'][k] not in k3)):
								res_mem_access_1 = memory_access_1(reservation_stations['A'][k])
								clk_mem_access_1 = clock + memory_access_time
								p_mem_access_1 = k

					if(t == 2):
						if(reservation_stations['op'][k] == 'LDR'):
							if(reservation_stations['id'][k] in store_buffer_id):
								k1 = store_buffer[:store_buffer_id.index(reservation_stations['id'][k])]
								if(reservation_stations['A'][k] not in k1):
									res_mem_access_2 = memory_access_2(reservation_stations['A'][k])
									clk_mem_access_2 = clock + memory_access_time
									p_mem_access_2 = k
							else:
								res_mem_access_2 = memory_access_2(reservation_stations['A'][k])
								clk_mem_access_2 = clock + memory_access_time
								p_mem_access_2 = k

						if(reservation_stations['op'][k] == 'STR'):
							k2 = []
							k3 = []
							if(reservation_stations['id'][k] in store_buffer_id):
								k2 = store_buffer[:store_buffer_id.index(reservation_stations['id'][k])]
							if(reservation_stations['id'][k] in load_buffer_id):
								k3 = load_buffer[:load_buffer_id.index(reservation_stations['id'][k])]
							if((reservation_stations['A'][k] not in k2) and (reservation_stations['A'][k] not in k3)):
								res_mem_access_2 = memory_access_1(reservation_stations['A'][k])
								clk_mem_access_2 = clock + memory_access_time
								p_mem_access_2 = k


	

	if(clock == clk_fp_adder_1):
		for p in qi.items():
			if(p[1] != []):
				if(p[1][0] == 'FADD1' or p[1][0] == 'FSUB1'):
					d = p[1][0]
					registers[int(p[0][1:])] = res_fp_adder_1	
					p[1].remove(d)

					g = reservation_stations['id'][reservation_stations['name'].index(d)]

					for j in range(0, 5):
						if((reservation_stations['Qj'][j] == g or reservation_stations['Qj'][j] == 'FADD1' or reservation_stations['Qj'][j] == 'FSUB1') and reservation_stations['busy'][j] == 1):
							reservation_stations['Qj'][j] = -1
							reservation_stations['Vj'][j] = res_fp_adder_1

						if((reservation_stations['Qk'][j] == g or reservation_stations['Qk'][j] == 'FADD1' or reservation_stations['Qk'][j] == 'FSUB1') and reservation_stations['busy'][j] == 1):
							reservation_stations['Qk'][j] = -1
							reservation_stations['Vk'][j] = res_fp_adder_1
						
					reservation_stations['name'][p_fp_adder_1] = ''						
					reservation_stations['op'][p_fp_adder_1] = ''	
					reservation_stations['Qj'][p_fp_adder_1] = -1
					reservation_stations['Qk'][p_fp_adder_1] = -1
					reservation_stations['Vj'][p_fp_adder_1] = ''
					reservation_stations['Vk'][p_fp_adder_1] = ''
					reservation_stations['A'][p_fp_adder_1] = ''
					reservation_stations['busy'][p_fp_adder_1] = 0
					reservation_stations['id'][p_fp_adder_1] = len(instructions1) + 1
					working[p_fp_adder_1] = 0	

					flag_fp_adder_1 = 0
					break

				elif('FADD1' in p[1] or 'FSUB1' in p[1]):
					clk_fp_adder_1 += 1	


	if(clock == clk_fp_adder_2):
		for p in qi.items():
			if(p[1] != []):
				if(p[1][0] == 'FADD2' or p[1][0] == 'FSUB2'):
					d = p[1][0]
					registers[int(p[0][1:])] = res_fp_adder_2	
					p[1].remove(d)

					g = reservation_stations['id'][reservation_stations['name'].index(d)]

					for j in range(0, 5):
						if((reservation_stations['Qj'][j] == g or reservation_stations['Qj'][j] == 'FADD2' or reservation_stations['Qj'][j] == 'FSUB2') and reservation_stations['busy'][j] == 1):
							reservation_stations['Qj'][j] = -1
							reservation_stations['Vj'][j] = res_fp_adder_2

						if((reservation_stations['Qk'][j] == g or reservation_stations['Qk'][j] == 'FADD2' or reservation_stations['Qk'][j] == 'FSUB2') and reservation_stations['busy'][j] == 1):
							reservation_stations['Qk'][j] = -1
							reservation_stations['Vk'][j] = res_fp_adder_2
						
					reservation_stations['name'][p_fp_adder_2] = ''						
					reservation_stations['op'][p_fp_adder_2] = ''	
					reservation_stations['Qj'][p_fp_adder_2] = -1
					reservation_stations['Qk'][p_fp_adder_2] = -1
					reservation_stations['Vj'][p_fp_adder_2] = ''
					reservation_stations['Vk'][p_fp_adder_2] = ''
					reservation_stations['A'][p_fp_adder_2] = ''
					reservation_stations['busy'][p_fp_adder_2] = 0
					reservation_stations['id'][p_fp_adder_2] = len(instructions1) + 1
					working[p_fp_adder_2] = 0	

					flag_fp_adder_2 = 0
					break

				elif('FADD2' in p[1] or 'FSUB2' in p[1]):
					clk_fp_adder_2 += 1


	if(clock == clk_fp_multiplier_1):
		for p in qi.items():
			if(p[1] != []):
				if(p[1][0] == 'FMUL1'):
					d = p[1][0]
					registers[int(p[0][1:])] = res_fp_multiplier_1	
					p[1].remove(d)

					g = reservation_stations['id'][reservation_stations['name'].index(d)]

					for j in range(0, 5):
						if((reservation_stations['Qj'][j] == g or reservation_stations['Qj'][j] == 'FMUL1') and reservation_stations['busy'][j] == 1):
							reservation_stations['Qj'][j] = -1
							reservation_stations['Vj'][j] = res_fp_multiplier_1

						if((reservation_stations['Qk'][j] == g or reservation_stations['Qk'][j] == 'FMUL1') and reservation_stations['busy'][j] == 1):
							reservation_stations['Qk'][j] = -1
							reservation_stations['Vk'][j] = res_fp_multiplier_1
						
					reservation_stations['name'][p_fp_multiplier_1] = ''						
					reservation_stations['op'][p_fp_multiplier_1] = ''	
					reservation_stations['Qj'][p_fp_multiplier_1] = -1
					reservation_stations['Qk'][p_fp_multiplier_1] = -1
					reservation_stations['Vj'][p_fp_multiplier_1] = ''
					reservation_stations['Vk'][p_fp_multiplier_1] = ''
					reservation_stations['A'][p_fp_multiplier_1] = ''
					reservation_stations['busy'][p_fp_multiplier_1] = 0
					reservation_stations['id'][p_fp_multiplier_1] = len(instructions1) + 1
					working[p_fp_multiplier_1] = 0	

					flag_fp_multiplier_1 = 0
					break

				elif('FMUL1' in p[1]):
					clk_fp_multiplier_1 += 1


	if(clock == clk_fp_multiplier_2):
		for p in qi.items():
			if(p[1] != []):
				if(p[1][0] == 'FMUL2'):
					d = p[1][0]
					registers[int(p[0][1:])] = res_fp_multiplier_2	
					p[1].remove(d)

					g = reservation_stations['id'][reservation_stations['name'].index(d)]

					for j in range(0, 5):
						if((reservation_stations['Qj'][j] == g or reservation_stations['Qj'][j] == 'FMUL2') and reservation_stations['busy'][j] == 1):
							reservation_stations['Qj'][j] = -1
							reservation_stations['Vj'][j] = res_fp_multiplier_2

						if((reservation_stations['Qk'][j] == g or reservation_stations['Qk'][j] == 'FMUL2') and reservation_stations['busy'][j] == 1):
							reservation_stations['Qk'][j] = -1
							reservation_stations['Vk'][j] = res_fp_multiplier_2
						
					reservation_stations['name'][p_fp_multiplier_2] = ''						
					reservation_stations['op'][p_fp_multiplier_2] = ''	
					reservation_stations['Qj'][p_fp_multiplier_2] = -1
					reservation_stations['Qk'][p_fp_multiplier_2] = -1
					reservation_stations['Vj'][p_fp_multiplier_2] = ''
					reservation_stations['Vk'][p_fp_multiplier_2] = ''
					reservation_stations['A'][p_fp_multiplier_2] = ''
					reservation_stations['busy'][p_fp_multiplier_2] = 0
					reservation_stations['id'][p_fp_multiplier_2] = len(instructions1) + 1
					working[p_fp_multiplier_2] = 0	

					flag_fp_multiplier_2 = 0
					break

				elif('FMUL2' in p[1]):
					clk_fp_multiplier_2 += 1


	if(clock == clk_int_adder_1):
		for p in qi.items():
			if(p[1] != []):
				if(p[1][0] == 'ADD1' or p[1][0] == 'SUB1' or p[1][0] == 'ADDC1' or p[1][0] == 'SBB1'):
					d = p[1][0]
					registers[int(p[0][1:])] = res_int_adder_1	
					p[1].remove(d)

					g = reservation_stations['id'][reservation_stations['name'].index(d)]

					for j in range(0, 5):
						if(reservation_stations['Qj'][j] == g or reservation_stations['Qj'][j] == 'ADD1' or reservation_stations['Qj'][j] == 'SUB1' or reservation_stations['Qj'][j] == 'ADDC1' or reservation_stations['Qj'][j] == 'SBB1'):
							reservation_stations['Qj'][j] = -1
							reservation_stations['Vj'][j] = res_int_adder_1

						if(reservation_stations['Qk'][j] == g or reservation_stations['Qk'][j] == 'ADD1' or reservation_stations['Qk'][j] == 'SUB1' or reservation_stations['Qk'][j] == 'ADDC1' or reservation_stations['Qk'][j] == 'SBB1'):
							reservation_stations['Qk'][j] = -1
							reservation_stations['Vk'][j] = res_int_adder_1
						
					reservation_stations['name'][p_int_adder_1] = ''						
					reservation_stations['op'][p_int_adder_1] = ''	
					reservation_stations['Qj'][p_int_adder_1] = -1
					reservation_stations['Qk'][p_int_adder_1] = -1
					reservation_stations['Vj'][p_int_adder_1] = ''
					reservation_stations['Vk'][p_int_adder_1] = ''
					reservation_stations['A'][p_int_adder_1] = ''
					reservation_stations['busy'][p_int_adder_1] = 0
					reservation_stations['id'][p_int_adder_1] = len(instructions1) + 1
					working[p_int_adder_1] = 0	

					flag_int_adder_1 = 0
					break

				elif('ADD1' in p[1] or 'SUB1' in p[1] or 'ADDC1' in p[1] or 'SBB1' in p[1]):
					clk_int_adder_1 += 1	


	if(clock == clk_int_adder_2):
		for p in qi.items():
			if(p[1] != []):
				if(p[1][0] == 'ADD2' or p[1][0] == 'SUB2' or p[1][0] == 'ADDC2' or p[1][0] == 'SBB2'):
					d = p[1][0]
					registers[int(p[0][1:])] = res_int_adder_2	
					p[1].remove(d)

					g = reservation_stations['id'][reservation_stations['name'].index(d)]

					for j in range(0, 5):
						if((reservation_stations['Qj'][j] == g or reservation_stations['Qj'][j] == 'ADD2' or reservation_stations['Qj'][j] == 'SUB2' or reservation_stations['Qj'][j] == 'ADDC2' or reservation_stations['Qj'][j] == 'SBB2') and reservation_stations['busy'][j] == 1):
							reservation_stations['Qj'][j] = -1
							reservation_stations['Vj'][j] = res_int_adder_2

						if((reservation_stations['Qk'][j] == g or reservation_stations['Qk'][j] == 'ADD2' or reservation_stations['Qk'][j] == 'SUB2' or reservation_stations['Qk'][j] == 'ADDC2' or reservation_stations['Qk'][j] == 'SBB2') and reservation_stations['busy'][j] == 1):
							reservation_stations['Qk'][j] = -1
							reservation_stations['Vk'][j] = res_int_adder_2
						
					reservation_stations['name'][p_int_adder_2] = ''						
					reservation_stations['op'][p_int_adder_2] = ''	
					reservation_stations['Qj'][p_int_adder_2] = -1
					reservation_stations['Qk'][p_int_adder_2] = -1
					reservation_stations['Vj'][p_int_adder_2] = ''
					reservation_stations['Vk'][p_int_adder_2] = ''
					reservation_stations['A'][p_int_adder_2] = ''
					reservation_stations['busy'][p_int_adder_2] = 0
					reservation_stations['id'][p_int_adder_2] = len(instructions1) + 1
					working[p_int_adder_2] = 0	

					flag_int_adder_2 = 0
					break

				elif('ADD2' in p[1] or 'SUB2' in p[1] or 'ADDC2' in p[1] or 'SBB2' in p[1]):
					clk_int_adder_2 += 1	


	if(clock == clk_int_multiplier_1):
		for p in qi.items():
			if(p[1] != []):
				if(p[1][0] == 'MUL1'):
					d = p[1][0]
					registers[int(p[0][1:])] = res_int_multiplier_1	
					p[1].remove(d)

					g = reservation_stations['id'][reservation_stations['name'].index(d)]

					for j in range(0, 5):
						if((reservation_stations['Qj'][j] == g or reservation_stations['Qj'][j] == 'MUL1') and reservation_stations['busy'][j] == 1):
							reservation_stations['Qj'][j] = -1
							reservation_stations['Vj'][j] = res_int_multiplier_1

						if((reservation_stations['Qk'][j] == g or reservation_stations['Qk'][j] == 'MUL1') and reservation_stations['busy'][j] == 1):
							reservation_stations['Qk'][j] = -1
							reservation_stations['Vk'][j] = res_int_multiplier_1
						
					reservation_stations['name'][p_int_multiplier_1] = ''						
					reservation_stations['op'][p_int_multiplier_1] = ''	
					reservation_stations['Qj'][p_int_multiplier_1] = -1
					reservation_stations['Qk'][p_int_multiplier_1] = -1
					reservation_stations['Vj'][p_int_multiplier_1] = ''
					reservation_stations['Vk'][p_int_multiplier_1] = ''
					reservation_stations['A'][p_int_multiplier_1] = ''
					reservation_stations['busy'][p_int_multiplier_1] = 0
					reservation_stations['id'][p_int_multiplier_1] = len(instructions1) + 1
					working[p_int_multiplier_1] = 0	

					flag_int_multiplier_1 = 0
					break

				elif('MUL1' in p[1]):
					clk_int_multiplier_1 += 1


	if(clock == clk_int_multiplier_2):
		for p in qi.items():
			if(p[1] != []):
				if(p[1][0] == 'MUL2'):
					d = p[1][0]
					registers[int(p[0][1:])] = res_int_multiplier_2	
					p[1].remove(d)

					g = reservation_stations['id'][reservation_stations['name'].index(d)]

					for j in range(0, 5):
						if((reservation_stations['Qj'][j] == g or reservation_stations['Qj'][j] == 'MUL2') and reservation_stations['busy'][j] == 1):
							reservation_stations['Qj'][j] = -1
							reservation_stations['Vj'][j] = res_int_multiplier_2

						if((reservation_stations['Qk'][j] == g or reservation_stations['Qk'][j] == 'MUL2') and reservation_stations['busy'][j] == 1):
							reservation_stations['Qk'][j] = -1
							reservation_stations['Vk'][j] = res_int_multiplier_2
						
					reservation_stations['name'][p_int_multiplier_2] = ''						
					reservation_stations['op'][p_int_multiplier_2] = ''	
					reservation_stations['Qj'][p_int_multiplier_2] = -1
					reservation_stations['Qk'][p_int_multiplier_2] = -1
					reservation_stations['Vj'][p_int_multiplier_2] = ''
					reservation_stations['Vk'][p_int_multiplier_2] = ''
					reservation_stations['A'][p_int_multiplier_2] = ''
					reservation_stations['busy'][p_int_multiplier_2] = 0
					reservation_stations['id'][p_int_multiplier_2] = len(instructions1) + 1
					working[p_int_multiplier_2] = 0	

					flag_int_multiplier_2 = 0
					break

				elif('MUL2' in p[1]):
					clk_int_multiplier_2 += 1


	if(clock == clk_int_logic_unit_1):
		for p in qi.items():
			if(p[1] != []):
				if(p[1][0] == 'CMP1' or p[1][0] == 'XOR1' or p[1][0] == 'NAND1' or p[1][0] == 'SHR1' or p[1][0] == 'LHR1'):
					d = p[1][0]
					registers[int(p[0][1:])] = res_int_logic_unit_1	
					p[1].remove(d)

					g = reservation_stations['id'][reservation_stations['name'].index(d)]

					for j in range(0, 5):
						if((reservation_stations['Qj'][j] == g or reservation_stations['Qj'][j] == 'CMP1' or reservation_stations['Qj'][j] == 'XOR1' or reservation_stations['Qj'][j] == 'NAND1' or reservation_stations['Qj'][j] == 'SHR1' or reservation_stations['Qj'][j] == 'LHR1') and reservation_stations['busy'][j] == 1):
							reservation_stations['Qj'][j] = -1
							reservation_stations['Vj'][j] = res_int_logic_unit_1

						if((reservation_stations['Qk'][j] == g or reservation_stations['Qk'][j] == 'CMP1' or reservation_stations['Qk'][j] == 'XOR1' or reservation_stations['Qk'][j] == 'NAND1' or reservation_stations['Qk'][j] == 'SHR1' or reservation_stations['Qk'][j] == 'LHR1') and reservation_stations['busy'][j] == 1):
							reservation_stations['Qk'][j] = -1
							reservation_stations['Vk'][j] = res_int_logic_unit_1
						
					reservation_stations['name'][p_int_logic_unit_1] = ''						
					reservation_stations['op'][p_int_logic_unit_1] = ''	
					reservation_stations['Qj'][p_int_logic_unit_1] = -1
					reservation_stations['Qk'][p_int_logic_unit_1] = -1
					reservation_stations['Vj'][p_int_logic_unit_1] = ''
					reservation_stations['Vk'][p_int_logic_unit_1] = ''
					reservation_stations['A'][p_int_logic_unit_1] = ''
					reservation_stations['busy'][p_int_logic_unit_1] = 0
					reservation_stations['id'][p_int_logic_unit_1] = len(instructions1) + 1
					working[p_int_logic_unit_1] = 0	

					flag_int_logic_unit_1 = 0
					break

				elif('CMP1' in p[1] or 'XOR1' in p[1] or 'NAND1' in p[1] or 'SHR1' in p[1] or 'LHR1' in p[1]):
					clk_int_logic_unit_1 += 1	


	if(clock == clk_int_logic_unit_2):
		for p in qi.items():
			if(p[1] != []):
				if(p[1][0] == 'CMP2' or p[1][0] == 'XOR2' or p[1][0] == 'NAND2' or p[1][0] == 'SHR2' or p[1][0] == 'LHR2'):
					d = p[1][0]
					registers[int(p[0][1:])] = res_int_logic_unit_2	
					p[1].remove(d)

					g = reservation_stations['id'][reservation_stations['name'].index(d)]

					for j in range(0, 5):
						if((reservation_stations['Qj'][j] == g or reservation_stations['Qj'][j] == 'CMP2' or reservation_stations['Qj'][j] == 'XOR2' or reservation_stations['Qj'][j] == 'NAND2' or reservation_stations['Qj'][j] == 'SHR2' or reservation_stations['Qj'][j] == 'LHR2') and reservation_stations['busy'][j] == 1):
							reservation_stations['Qj'][j] = -1
							reservation_stations['Vj'][j] = res_int_logic_unit_2

						if((reservation_stations['Qk'][j] == g or reservation_stations['Qk'][j] == 'CMP2' or reservation_stations['Qk'][j] == 'XOR2' or reservation_stations['Qk'][j] == 'NAND2' or reservation_stations['Qk'][j] == 'SHR2' or reservation_stations['Qk'][j] == 'LHR2') and reservation_stations['busy'][j] == 1):
							reservation_stations['Qk'][j] = -1
							reservation_stations['Vk'][j] = res_int_logic_unit_2
						
					reservation_stations['name'][p_int_logic_unit_2] = ''						
					reservation_stations['op'][p_int_logic_unit_2] = ''	
					reservation_stations['Qj'][p_int_logic_unit_2] = -1
					reservation_stations['Qk'][p_int_logic_unit_2] = -1
					reservation_stations['Vj'][p_int_logic_unit_2] = ''
					reservation_stations['Vk'][p_int_logic_unit_2] = ''
					reservation_stations['A'][p_int_logic_unit_2] = ''
					reservation_stations['busy'][p_int_logic_unit_2] = 0
					reservation_stations['id'][p_int_logic_unit_2] = len(instructions1) + 1
					working[p_int_logic_unit_2] = 0	

					flag_int_logic_unit_2 = 0
					break

				elif('CMP2' in p[1] or 'XOR2' in p[1] or 'NAND2' in p[1] or 'SHR2' in p[1] or 'LHR2' in p[1]):
					clk_int_logic_unit_2 += 1	




	if(clock == clk_mem_access_1):
		if(reservation_stations['name'][p_mem_access_1] == 'LDR1'):
			for p in qi.items():
				if(p[1] != []):
					if(p[1][0] == 'LDR1'):
						d = p[1][0]
						registers[int(p[0][1:])] = main_memory[res_mem_access_1]
						p[1].remove(d)
						
						g = reservation_stations['id'][reservation_stations['name'].index(d)]		
						if(g in load_buffer_id):
							s1 = load_buffer_id.index(g)
							load_buffer.pop(s1)
							load_buffer_id.pop(s1)
							load_buffer_name.pop(s1)

						for j in range(0, 5):
							if((reservation_stations['Qj'][j] == g or reservation_stations['Qj'][j] == 'LDR1') and reservation_stations['busy'][j] == 1):
								reservation_stations['Qj'][j] = -1
								reservation_stations['Vj'][j] = main_memory[res_mem_access_1]

							if((reservation_stations['Qk'][j] == g or reservation_stations['Qk'][j] == 'LDR1') and reservation_stations['busy'][j] == 1):
								reservation_stations['Qk'][j] = -1
								reservation_stations['Vk'][j] = main_memory[res_mem_access_1]
			
						reservation_stations['name'][p_mem_access_1] = ''						
						reservation_stations['op'][p_mem_access_1] = ''	
						reservation_stations['Qj'][p_mem_access_1] = -1
						reservation_stations['Qk'][p_mem_access_1] = -1
						reservation_stations['Vj'][p_mem_access_1] = ''
						reservation_stations['Vk'][p_mem_access_1] = ''
						reservation_stations['A'][p_mem_access_1] = ''
						reservation_stations['busy'][p_mem_access_1] = 0 
						reservation_stations['id'][p_mem_access_1] = len(instructions1) + 1
						working[p_mem_access_1] = 0

						flag_mem_access_1 = 0
						break

					elif('LDR1' in p[1]):
						clk_mem_access_1 += 1

		else:
			for p in qi.items():
				if(p[1] != []):
					if(p[1][0] == 'STR1'):
						d = p[1][0]
						main_memory[res_mem_access_1] = registers[int(p[0][1:])]
						p[1].remove(d)
						
						g = reservation_stations['id'][reservation_stations['name'].index(d)]		

						if(g in store_buffer_id):
							s1 = store_buffer_id.index(g)
							store_buffer.pop(s1)
							store_buffer_id.pop(s1)
							store_buffer_name.pop(s1)
					
						for j in range(0, 5):
							if((reservation_stations['Qj'][j] == g or reservation_stations['Qj'][j] == 'STR1') and reservation_stations['busy'][j] == 1):
								reservation_stations['Qj'][j] = -1
								reservation_stations['Vj'][j] = registers[int(p[0][1:])]

							if((reservation_stations['Qk'][j] == g or reservation_stations['Qk'][j] == 'STR1') and reservation_stations['busy'][j] == 1):
								reservation_stations['Qk'][j] = -1
								reservation_stations['Vk'][j] = registers[int(p[0][1:])]
			
						reservation_stations['name'][p_mem_access_1] = ''						
						reservation_stations['op'][p_mem_access_1] = ''	
						reservation_stations['Qj'][p_mem_access_1] = -1
						reservation_stations['Qk'][p_mem_access_1] = -1
						reservation_stations['Vj'][p_mem_access_1] = ''
						reservation_stations['Vk'][p_mem_access_1] = ''
						reservation_stations['A'][p_mem_access_1] = ''
						reservation_stations['busy'][p_mem_access_1] = 0 
						reservation_stations['id'][p_mem_access_1] = len(instructions1) + 1
						working[p_mem_access_1] = 0

						flag_mem_access_1 = 0
						break

					elif('STR1' in p[1]):
						clk_mem_access_1 += 1

				
	if(clock == clk_mem_access_2):
		if(reservation_stations['name'][p_mem_access_2] == 'LDR2'):
			for p in qi.items():
				if(p[1] != []):
					if(p[1][0] == 'LDR2'):
						d = p[1][0]
						registers[int(p[0][1:])] = main_memory[res_mem_access_2]
						p[1].remove(d)
						
						g = reservation_stations['id'][reservation_stations['name'].index(d)]		

						if(g in load_buffer_id):
							s1 = load_buffer_id.index(g)
							load_buffer.pop(s1)
							load_buffer_id.pop(s1)
							load_buffer_name.pop(s1)

						for j in range(0, 5):
							if((reservation_stations['Qj'][j] == g or reservation_stations['Qj'][j] == 'LDR2') and reservation_stations['busy'][j] == 1):
								reservation_stations['Qj'][j] = -1
								reservation_stations['Vj'][j] = main_memory[res_mem_access_2]

							if((reservation_stations['Qk'][j] == g or reservation_stations['Qk'][j] == 'LDR2') and reservation_stations['busy'][j] == 1):
								reservation_stations['Qk'][j] = -1
								reservation_stations['Vk'][j] = main_memory[res_mem_access_2]
			
						reservation_stations['name'][p_mem_access_2] = ''						
						reservation_stations['op'][p_mem_access_2] = ''	
						reservation_stations['Qj'][p_mem_access_2] = -1
						reservation_stations['Qk'][p_mem_access_2] = -1
						reservation_stations['Vj'][p_mem_access_2] = ''
						reservation_stations['Vk'][p_mem_access_2] = ''
						reservation_stations['A'][p_mem_access_2] = ''
						reservation_stations['busy'][p_mem_access_2] = 0 
						reservation_stations['id'][p_mem_access_2] = len(instructions1) + 1
						working[p_mem_access_2] = 0

						flag_mem_access_2 = 0
						break

					elif('LDR2' in p[1]):
						clk_mem_access_2 += 1

		else:
			for p in qi.items():
				if(p[1] != []):
					if(p[1][0] == 'STR2'):
						d = p[1][0]
						main_memory[res_mem_access_2] = registers[int(p[0][1:])]
						p[1].remove(d)
						
						g = reservation_stations['id'][reservation_stations['name'].index(d)]		

						if(g in store_buffer_id):
							s1 = store_buffer_id.index(g)
							store_buffer.pop(s1)
							store_buffer_id.pop(s1)
							store_buffer_name.pop(s1)
					
						for j in range(0, 5):
							if((reservation_stations['Qj'][j] == g or reservation_stations['Qj'][j] == 'STR2') and reservation_stations['busy'][j] == 1):
								reservation_stations['Qj'][j] = -1
								reservation_stations['Vj'][j] = registers[int(p[0][1:])]

							if((reservation_stations['Qk'][j] == g or reservation_stations['Qk'][j] == 'STR2') and reservation_stations['busy'][j] == 1):
								reservation_stations['Qk'][j] = -1
								reservation_stations['Vk'][j] = registers[int(p[0][1:])]
			
						reservation_stations['name'][p_mem_access_2] = ''						
						reservation_stations['op'][p_mem_access_2] = ''	
						reservation_stations['Qj'][p_mem_access_2] = -1
						reservation_stations['Qk'][p_mem_access_2] = -1
						reservation_stations['Vj'][p_mem_access_2] = ''
						reservation_stations['Vk'][p_mem_access_2] = ''
						reservation_stations['A'][p_mem_access_2] = ''
						reservation_stations['busy'][p_mem_access_2] = 0 
						reservation_stations['id'][p_mem_access_2] = len(instructions1) + 1
						working[p_mem_access_2] = 0

						flag_mem_access_2 = 0
						break

					elif('STR2' in p[1]):
						clk_mem_access_2 += 1
	



	list_fadd = []
	list_fmul = []
	list_intadd = []
	list_intmul = []
	list_intlu = []
	list_mem = []

	for j in range(0, 5):
		if(reservation_stations['name'][j] == '' and reservation_stations['busy'][j] == 1):
			if((reservation_stations['op'][j] == 'FADD' or reservation_stations['op'][j] == 'FSUB') and (flag_fp_adder_1 == 0 or flag_fp_adder_2 == 0)):
				list_fadd.append(j)
			if((reservation_stations['op'][j] == 'FMUL') and (flag_fp_multiplier_1 == 0 or flag_fp_multiplier_2 == 0)):
				list_fmul.append(j)
			if((reservation_stations['op'][j] == 'ADD' or reservation_stations['op'][j] == 'ADDC' or reservation_stations['op'][j] == 'SUB' or reservation_stations['op'][j] == 'SBB') and (flag_int_adder_1 == 0 or flag_int_adder_2 == 0)):
				list_intadd.append(j)
			if((reservation_stations['op'][j] == 'MUL') and (flag_int_multiplier_1 == 0 or flag_int_multiplier_2 == 0)):
				list_intmul.append(j)
			if((reservation_stations['op'][j] == 'CMP' or reservation_stations['op'][j] == 'XOR' or reservation_stations['op'][j] == 'NAND' or reservation_stations['op'][j] == 'SHR' or reservation_stations['op'][j] == 'LHR') and (flag_int_logic_unit_1 == 0 or flag_int_logic_unit_2 == 0)):
				list_intlu.append(j)
			if((reservation_stations['op'][j] == 'LDR' or reservation_stations['op'][j] == 'STR') and (flag_mem_access_1 == 0 or flag_fp_multiplier_2 == 0)):
				list_mem.append(j)


	if(list_fadd != []):
		h = []
		for k in list_fadd:
			h.append(reservation_stations['id'][k])
		zipped_lists = zip(h, list_fadd)
		sorted_zipped_lists = sorted(zipped_lists)
		sorted_list1 = [element for _, element in sorted_zipped_lists]
		
		if(flag_fp_adder_1 == 0):
			reservation_stations['name'][sorted_list1[0]] = reservation_stations['op'][sorted_list1[0]] + str(1)
			flag_fp_adder_1 = 1
			for p in qi.items():
				if(reservation_stations['id'][sorted_list1[0]] in p[1]):
					p[1][p[1].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qj']):
				reservation_stations['Qj'][reservation_stations['Qj'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qk']):
				reservation_stations['Qk'][reservation_stations['Qk'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
		else:
			reservation_stations['name'][sorted_list1[0]] = reservation_stations['op'][sorted_list1[0]] + str(2)
			flag_fp_adder_2 = 1
			for p in qi.items():
				if(reservation_stations['id'][sorted_list1[0]] in p[1]):
					p[1][p[1].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qj']):
				reservation_stations['Qj'][reservation_stations['Qj'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qk']):
				reservation_stations['Qk'][reservation_stations['Qk'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]

		if(len(sorted_list1) != 1):
			list1 = sorted_list1[1:]
			sorted_list1 = list(list1)
			if(flag_fp_adder_1 == 0):
				reservation_stations['name'][sorted_list1[0]] = reservation_stations['op'][sorted_list1[0]] + str(1)
				flag_fp_adder_1 = 1
				for p in qi.items():
					if(reservation_stations['id'][sorted_list1[0]] in p[1]):
						p[1][p[1].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
				if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qj']):
					reservation_stations['Qj'][reservation_stations['Qj'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
				if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qk']):
					reservation_stations['Qk'][reservation_stations['Qk'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			elif(flag_fp_adder_2 == 0):
				reservation_stations['name'][sorted_list1[0]] = reservation_stations['op'][sorted_list1[0]] + str(2)
				flag_fp_adder_2 = 1
				for p in qi.items():
					if(reservation_stations['id'][sorted_list1[0]] in p[1]):
						p[1][p[1].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
				if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qj']):
					reservation_stations['Qj'][reservation_stations['Qj'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
				if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qk']):
					reservation_stations['Qk'][reservation_stations['Qk'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]

	
	if(list_fmul != []):
		h = []
		for k in list_fmul:
			h.append(reservation_stations['id'][k])
		zipped_lists = zip(h, list_fmul)
		sorted_zipped_lists = sorted(zipped_lists)
		sorted_list1 = [element for _, element in sorted_zipped_lists]
		
		if(flag_fp_multiplier_1 == 0):
			reservation_stations['name'][sorted_list1[0]] = reservation_stations['op'][sorted_list1[0]] + str(1)
			flag_fp_multiplier_1 = 1
			for p in qi.items():
				if(reservation_stations['id'][sorted_list1[0]] in p[1]):
					p[1][p[1].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qj']):
				reservation_stations['Qj'][reservation_stations['Qj'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qk']):
				reservation_stations['Qk'][reservation_stations['Qk'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
		else:
			reservation_stations['name'][sorted_list1[0]] = reservation_stations['op'][sorted_list1[0]] + str(2)
			flag_fp_multiplier_2 = 1
			for p in qi.items():
				if(reservation_stations['id'][sorted_list1[0]] in p[1]):
					p[1][p[1].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qj']):
				reservation_stations['Qj'][reservation_stations['Qj'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qk']):
				reservation_stations['Qk'][reservation_stations['Qk'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
		
		if(len(sorted_list1) != 1):
			list1 = sorted_list1[1:]
			sorted_list1 = list(list1)
			if(flag_fp_multiplier_1 == 0):
				reservation_stations['name'][sorted_list1[0]] = reservation_stations['op'][sorted_list1[0]] + str(1)
				flag_fp_multiplier_1 = 1
				for p in qi.items():
					if(reservation_stations['id'][sorted_list1[0]] in p[1]):
						p[1][p[1].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
				if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qj']):
					reservation_stations['Qj'][reservation_stations['Qj'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
				if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qk']):
					reservation_stations['Qk'][reservation_stations['Qk'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			elif(flag_fp_multiplier_2 == 0):
				reservation_stations['name'][sorted_list1[0]] = reservation_stations['op'][sorted_list1[0]] + str(2)
				flag_fp_multiplier_2 = 1
				for p in qi.items():
					if(reservation_stations['id'][sorted_list1[0]] in p[1]):
						p[1][p[1].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
				if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qj']):
					reservation_stations['Qj'][reservation_stations['Qj'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
				if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qk']):
					reservation_stations['Qk'][reservation_stations['Qk'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]

	
	if(list_intadd != []):
		h = []
		for k in list_intadd:
			h.append(reservation_stations['id'][k])
		zipped_lists = zip(h, list_intadd)
		sorted_zipped_lists = sorted(zipped_lists)
		sorted_list1 = [element for _, element in sorted_zipped_lists]
		
		if(flag_int_adder_1 == 0):
			reservation_stations['name'][sorted_list1[0]] = reservation_stations['op'][sorted_list1[0]] + str(1)
			flag_int_adder_1 = 1
			for p in qi.items():
				if(reservation_stations['id'][sorted_list1[0]] in p[1]):
					p[1][p[1].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qj']):
				reservation_stations['Qj'][reservation_stations['Qj'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qk']):
				reservation_stations['Qk'][reservation_stations['Qk'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
		else:
			reservation_stations['name'][sorted_list1[0]] = reservation_stations['op'][sorted_list1[0]] + str(2)
			flag_int_adder_2 = 1
			for p in qi.items():
				if(reservation_stations['id'][sorted_list1[0]] in p[1]):
					p[1][p[1].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qj']):
				reservation_stations['Qj'][reservation_stations['Qj'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qk']):
				reservation_stations['Qk'][reservation_stations['Qk'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
		
		if(len(sorted_list1) != 1):
			list1 = sorted_list1[1:]
			sorted_list1 = list(list1)
			if(flag_int_adder_1 == 0):
				reservation_stations['name'][sorted_list1[0]] = reservation_stations['op'][sorted_list1[0]] + str(1)
				flag_int_adder_1 = 1
				for p in qi.items():
					if(reservation_stations['id'][sorted_list1[0]] in p[1]):
						p[1][p[1].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
				if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qj']):
					reservation_stations['Qj'][reservation_stations['Qj'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
				if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qk']):
					reservation_stations['Qk'][reservation_stations['Qk'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			elif(flag_int_adder_2 == 0):
				reservation_stations['name'][sorted_list1[0]] = reservation_stations['op'][sorted_list1[0]] + str(2)
				flag_int_adder_2 = 1
				for p in qi.items():
					if(reservation_stations['id'][sorted_list1[0]] in p[1]):
						p[1][p[1].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
				if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qj']):
					reservation_stations['Qj'][reservation_stations['Qj'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
				if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qk']):
					reservation_stations['Qk'][reservation_stations['Qk'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]


	if(list_intmul != []):
		h = []
		for k in list_intmul:
			h.append(reservation_stations['id'][k])
		zipped_lists = zip(h, list_intmul)
		sorted_zipped_lists = sorted(zipped_lists)
		sorted_list1 = [element for _, element in sorted_zipped_lists]
		
		if(flag_int_multiplier_1 == 0):
			reservation_stations['name'][sorted_list1[0]] = reservation_stations['op'][sorted_list1[0]] + str(1)
			flag_int_multiplier_1 = 1
			for p in qi.items():
				if(reservation_stations['id'][sorted_list1[0]] in p[1]):
					p[1][p[1].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qj']):
				reservation_stations['Qj'][reservation_stations['Qj'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qk']):
				reservation_stations['Qk'][reservation_stations['Qk'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
		else:
			reservation_stations['name'][sorted_list1[0]] = reservation_stations['op'][sorted_list1[0]] + str(2)
			flag_int_multiplier_2 = 1
			for p in qi.items():
				if(reservation_stations['id'][sorted_list1[0]] in p[1]):
					p[1][p[1].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qj']):
				reservation_stations['Qj'][reservation_stations['Qj'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qk']):
				reservation_stations['Qk'][reservation_stations['Qk'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]

		if(len(sorted_list1) != 1):
			list1 = sorted_list1[1:]
			sorted_list1 = list(list1)
			if(flag_int_multiplier_1 == 0):
				reservation_stations['name'][sorted_list1[0]] = reservation_stations['op'][sorted_list1[0]] + str(1)
				flag_int_multiplier_1 = 1
				for p in qi.items():
					if(reservation_stations['id'][sorted_list1[0]] in p[1]):
						p[1][p[1].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
				if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qj']):
					reservation_stations['Qj'][reservation_stations['Qj'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
				if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qk']):
					reservation_stations['Qk'][reservation_stations['Qk'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]	
			elif(flag_int_multiplier_2 == 0):
				reservation_stations['name'][sorted_list1[0]] = reservation_stations['op'][sorted_list1[0]] + str(2)
				flag_int_multiplier_2 = 1
				for p in qi.items():
					if(reservation_stations['id'][sorted_list1[0]] in p[1]):
						p[1][p[1].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
				if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qj']):
					reservation_stations['Qj'][reservation_stations['Qj'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
				if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qk']):
					reservation_stations['Qk'][reservation_stations['Qk'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]	


	if(list_intlu != []):
		h = []
		for k in list_intlu:
			h.append(reservation_stations['id'][k])
		zipped_lists = zip(h, list_intlu)
		sorted_zipped_lists = sorted(zipped_lists)
		sorted_list1 = [element for _, element in sorted_zipped_lists]
		
		if(flag_int_logic_unit_1 == 0):
			reservation_stations['name'][sorted_list1[0]] = reservation_stations['op'][sorted_list1[0]] + str(1)
			flag_int_logic_unit_1 = 1
			for p in qi.items():
				if(reservation_stations['id'][sorted_list1[0]] in p[1]):
					p[1][p[1].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qj']):
				reservation_stations['Qj'][reservation_stations['Qj'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qk']):
				reservation_stations['Qk'][reservation_stations['Qk'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
		else:
			reservation_stations['name'][sorted_list1[0]] = reservation_stations['op'][sorted_list1[0]] + str(2)
			flag_int_logic_unit_2 = 1
			for p in qi.items():
				if(reservation_stations['id'][sorted_list1[0]] in p[1]):
					p[1][p[1].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qj']):
				reservation_stations['Qj'][reservation_stations['Qj'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qk']):
				reservation_stations['Qk'][reservation_stations['Qk'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]

		if(len(sorted_list1) != 1):
			list1 = sorted_list1[1:]
			sorted_list1 = list(list1)
			if(flag_int_logic_unit_1 == 0):
				reservation_stations['name'][sorted_list1[0]] = reservation_stations['op'][sorted_list1[0]] + str(1)
				flag_int_logic_unit_1 = 1
				for p in qi.items():
					if(reservation_stations['id'][sorted_list1[0]] in p[1]):
						p[1][p[1].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
				if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qj']):
					reservation_stations['Qj'][reservation_stations['Qj'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
				if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qk']):
					reservation_stations['Qk'][reservation_stations['Qk'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			elif(flag_int_logic_unit_2 == 0):
				reservation_stations['name'][sorted_list1[0]] = reservation_stations['op'][sorted_list1[0]] + str(2)
				flag_int_logic_unit_2 = 1
				for p in qi.items():
					if(reservation_stations['id'][sorted_list1[0]] in p[1]):
						p[1][p[1].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
				if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qj']):
					reservation_stations['Qj'][reservation_stations['Qj'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
				if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qk']):
					reservation_stations['Qk'][reservation_stations['Qk'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]


	if(list_mem != []):
		h = []
		for k in list_mem:
			h.append(reservation_stations['id'][k])
		zipped_lists = zip(h, list_mem)
		sorted_zipped_lists = sorted(zipped_lists)
		sorted_list1 = [element for _, element in sorted_zipped_lists]
		if(flag_mem_access_1 == 0):
			reservation_stations['name'][sorted_list1[0]] = reservation_stations['op'][sorted_list1[0]] + str(1)
			flag_mem_access_1 = 1
			for p in qi.items():
				if(reservation_stations['id'][sorted_list1[0]] in p[1]):
					p[1][p[1].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qj']):
				reservation_stations['Qj'][reservation_stations['Qj'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qk']):
				reservation_stations['Qk'][reservation_stations['Qk'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
		elif(flag_mem_access_2 == 0):
			reservation_stations['name'][sorted_list1[0]] = reservation_stations['op'][sorted_list1[0]] + str(2)
			flag_mem_access_2 = 1
			for p in qi.items():
				if(reservation_stations['id'][sorted_list1[0]] in p[1]):
					p[1][p[1].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qj']):
				reservation_stations['Qj'][reservation_stations['Qj'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qk']):
				reservation_stations['Qk'][reservation_stations['Qk'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]

		if(len(sorted_list1) != 1):
			list1 = sorted_list1[1:]
			sorted_list1 = list(list1)
			if(flag_mem_access_1 == 0):
				reservation_stations['name'][sorted_list1[0]] = reservation_stations['op'][sorted_list1[0]] + str(1)
				flag_mem_access_1 = 1
				for p in qi.items():
					if(reservation_stations['id'][sorted_list1[0]] in p[1]):
						p[1][p[1].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
				if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qj']):
					reservation_stations['Qj'][reservation_stations['Qj'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
				if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qk']):
					reservation_stations['Qk'][reservation_stations['Qk'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
			elif(flag_mem_access_2 == 0):
				reservation_stations['name'][sorted_list1[0]] = reservation_stations['op'][sorted_list1[0]] + str(2)
				flag_mem_access_2 = 1
				for p in qi.items():
					if(reservation_stations['id'][sorted_list1[0]] in p[1]):
						p[1][p[1].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
				if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qj']):
					reservation_stations['Qj'][reservation_stations['Qj'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]
				if(reservation_stations['id'][sorted_list1[0]] in reservation_stations['Qk']):
					reservation_stations['Qk'][reservation_stations['Qk'].index(reservation_stations['id'][sorted_list1[0]])] = reservation_stations['name'][sorted_list1[0]]




	print("\nclk = ", clock)
	print("reservation_stations :")
	print("name :", reservation_stations['name'])
	print("op :	", reservation_stations['op'])
	print("Qj :	", reservation_stations['Qj'])
	print("Qk :	", reservation_stations['Qk'])
	print("Vj :	", reservation_stations['Vj'])
	print("Vk :	", reservation_stations['Vk'])
	print("A :	", reservation_stations['A'])
	print("busy :	", reservation_stations['busy'])
	print("id :	", reservation_stations['id'])
	print("registers :	", registers)
	print("qi : ", qi)
	print("main memory :	", main_memory)

	print("load_buffer : ", load_buffer)
	print("load_buffer_name : ", load_buffer_name)
	print("load_buffer_id :	", load_buffer_id)
	print("store_buffer : ", store_buffer)
	print("store_buffer_name : ", store_buffer_name)
	print("store_buffer_id :	", store_buffer_id)	


	if(reservation_stations['op'][reservation_stations['id'].index(min(reservation_stations['id']))] == 'HLT'):
		break


	clock += 1			