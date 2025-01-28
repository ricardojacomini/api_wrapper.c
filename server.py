from flask import Flask, request, jsonify
import numpy as np
import logging

# Set up logging
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(message)s')

app = Flask(__name__)

@app.route('/invert-matrix', methods=['POST'])
def invert_matrix():
    data = request.json
    if not data or 'matrix' not in data:
        return jsonify({"error": "Matrix not provided"}), 400

    matrix = np.array(data['matrix'])

    try:
        # Calculate the inverse of the matrix
        inverted_matrix = np.linalg.inv(matrix).tolist()
    except np.linalg.LinAlgError:
        return jsonify({"error": "Matrix is not invertible"}), 400

    # Log each incoming request
    app.logger.info(f"Request received: {request.method} {request.url}")

    client_ip = request.remote_addr
    app.logger.info(f"Request received from {client_ip}: {request.method} {request.url}")
    app.logger.info(f"Headers: {request.headers}")
    app.logger.info(f"Payload: {request.data}")


    # return jsonify({"original_matrix": data['matrix'], "inverted_matrix": inverted_matrix})
    return jsonify({"inverted_matrix": inverted_matrix})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)

