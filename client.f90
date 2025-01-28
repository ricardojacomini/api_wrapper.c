module api_module
    use iso_c_binding
    implicit none

    interface
        subroutine send_matrix(url, json_payload, response_buffer, buffer_size) bind(C, name="send_matrix")
            import :: c_char, c_size_t
            character(kind=c_char), intent(in) :: url(*)
            character(kind=c_char), intent(in) :: json_payload(*)
            character(kind=c_char), intent(out) :: response_buffer(*)
            integer(c_size_t), value :: buffer_size
        end subroutine send_matrix
    end interface
end module api_module

program matrix_client
    use api_module
    use iso_c_binding
    implicit none

    ! Declare the variables with proper types
    character(kind=c_char, len=256) :: url
    character(kind=c_char, len=1024) :: json_payload
    character(kind=c_char, len=4096) :: response_buffer
    integer(c_size_t) :: buffer_size

    ! Define the URL of the API
    url = "http://172.20.11.21:5000/invert-matrix" // c_null_char

    ! Create a JSON payload with the matrix data
    json_payload = '{"matrix": [[4.0, 7.0], [2.0, 6.0]]}' // c_null_char

    ! Initialize the response buffer
    response_buffer = c_null_char

    ! Get the buffer size
    buffer_size = len(response_buffer)

    ! Print the original matrix
    print *, "Original matrix: "
    print *, "[[4.0, 7.0], [2.0, 6.0]]"

    ! Send the matrix data to the server and receive the response
    call send_matrix(url, json_payload, response_buffer, buffer_size)

    ! Print the server's response
    print *, "Server response: ", trim(adjustl(response_buffer))
end program matrix_client
