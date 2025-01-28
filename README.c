# C Wrapper
# The C wrapper needs to handle the response from the server and pass it back to Fortran.
# C Wrapper Code (api_wrapper.c)

ml curl/8.4.0
gcc -c api_wrapper.c -o api_wrapper.o -lcurl
