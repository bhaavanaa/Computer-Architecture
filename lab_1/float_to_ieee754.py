### Function to convert decimal to binary
# upto k-precision after decimal point  
def decimalToBinary(num, k_prec) : 
    binary = ""  
  
    # Fetch the integral part of 
    # decimal number  
    Integral = int(num)  
  
    # Fetch the fractional part  
    # decimal number  
    fractional = num - Integral 
  
    # Conversion of integral part to  
    # binary equivalent  
    while (Integral) : 
          
        rem = Integral % 2
  
        # Append 0 in binary  
        binary += str(rem);  
  
        Integral //= 2
      
    # Reverse string to get original 
    # binary equivalent  
    binary = binary[ : : -1]  
  
    # Append point before conversion  
    # of fractional part  
    binary += '.'
  
    # Conversion of fractional part 
    # to binary equivalent  
    while (k_prec) : 
          
        # Find next bit in fraction  
        fractional *= 2
        fract_bit = int(fractional)  
  
        if (fract_bit == 1) : 
              
            fractional -= fract_bit  
            binary += '1'
              
        else : 
            binary += '0'
  
        k_prec -= 1
  
    return binary


### To convert a decimal to binary
def dToB(n):
	return bin(n).replace("0b","")  


### Take the input floating point numbers
a=input("enter the number : ")		#first floating point input


### Save the sign bit
if(a[0]=='-'):
	asign=1
	a1=a[1:]
else:
	asign=0
	a1=a
#print(a1)


### Convert the the numbers into binary form
a2=float(a1)
ab=decimalToBinary(a2, 10)
#print(ab)


### Find the exponent
a3=str(ab).split(".")
alw=len(a3[0])
ald=len(a3[1])
#print(alw, ald)


aexp1=dToB(alw-1)
#print(aexp1)
l=len(str(aexp1))
n=5-l
s='0'
t=''.join([char*n for char in s])
#print(t)
if(5-l<0):
	print("error")
else:
	aexp=t+str(aexp1)
#print(aexp)


### Remove the extra digits from mantissa
am=a3[0][1:]+a3[1][:10-(alw-1)]
#print(am)

print("ieee 754 notation of ", a, " = ", asign, " ", am, " ", aexp)
