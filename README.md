# This project explains how to use the Fortran client (`client.f90`) with the C wrapper (`api_wrapper.c`) to interact with the Python Flask API (`server.py`) in Highi-Performance Computing (HPC) Cluster.

```markdown
# Matrix Inversion API Client-Server Example

This repository demonstrates how to use a Fortran client to send a matrix to a Python Flask API for inversion. Since Fortran does not have native support for HTTP requests, a C wrapper is used to handle the HTTP communication.

## Prerequisites

- **Fortran Compiler**: `gfortran` (GNU Fortran)
- **C Compiler**: `gcc` (GNU C Compiler)
- **cURL Library**: Required for HTTP requests in the C wrapper.
- **Python 3**: Required to run the Flask server.
- **Flask**: Python web framework.
- **NumPy**: Python library for numerical computations.

## Setup

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/matrix-api-client-server.git
cd matrix-api-client-server
```

### 2. Set Up the Python Environment

1. Create a virtual environment and activate it:

    ```bash
    $ python3 -m venv venv
    $ source venv/bin/activate
    ```

2. Install the required Python packages:

    ```bash
    $ pip install flask numpy
    ```

### 3. Compile the C Wrapper

The C wrapper (`api_wrapper.c`) uses the `libcurl` library to handle HTTP requests. Compile it as follows:

```bash
$ module load curl
$ gcc -c api_wrapper.c -o api_wrapper.o -lcurl
```

### 4. Compile the Fortran Client

The Fortran client (`client.f90`) calls the C wrapper to send the matrix to the server. Compile it as follows:

```bash
$ module load curl
$ gfortran -g client.f90 api_wrapper.o -o client -lcurl
```

### 5. Start the Flask Server

Run the Flask server (`server.py`) to handle incoming requests:

```bash
$ python server.py
```

The server will start on `http://0.0.0.0:5000`.

## Usage

### Running the Fortran Client

Once the server is running, execute the Fortran client:

```bash
$ ./client
```

The client will send a matrix to the server, receive the inverted matrix, and print both the original and inverted matrices.

### Example Output

```
 Original matrix: 
 [[4.0, 7.0], [2.0, 6.0]]
 Server response: {"inverted_matrix": [[0.6, -0.7], [-0.2, 0.4]]}
```

### Testing with cURL

You can also test the API directly using `cURL`:

```bash
curl -v -X POST http://172.20.11.21:5000/invert-matrix -H "Content-Type: application/json" -d '{"matrix": [[4.0, 7.0], [2.0, 6.0]]}'
```

## Service Setup (Optional)

To run the Flask server as a service, you can use the provided `server.service.txt` file. Follow these steps:

1. Copy the service file to the systemd directory:

    ```bash
    $ sudo cp server.service /etc/systemd/server.service
    ```

2. Reload the systemd daemon:

    ```bash
    $ sudo systemctl daemon-reload
    ```

3. Start and enable the service:

    ```bash
    $ sudo systemctl start server.service
    $ sudo systemctl enable server.service
    ```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## Acknowledgments

- [Flask](https://flask.palletsprojects.com/) for the web framework.
- [NumPy](https://numpy.org/) for matrix operations.
- [libcurl](https://curl.se/libcurl/) for HTTP requests in C.
```

