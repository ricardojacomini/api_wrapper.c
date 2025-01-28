# Fortran Client
# The Fortran program will send the matrix, receive the response, and print both the original and inverted matrices.
# Fortran Code (client.f90)

# test command line
#  curl -v -X POST http://172.20.11.21:5000/invert-matrix -H "Content-Type: application/json" -d '{"matrix": [[4.0, 7.0], [2.0, 6.0]]}'

ml curl/8.4.0
gfortran -g client.f90 api_wrapper.o -o client -lcurl

