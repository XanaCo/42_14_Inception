import http.server
import ssl

# Define the HTTP handler class
class SimpleHTTPRequestHandler(http.server.BaseHTTPRequestHandler):
    # Define the do_GET method to handle GET requests
    def do_GET(self):
        # Check if the request path is '/'
        if self.path == '/':
            # Set the response code to 200 OK
            self.send_response(200)
            # Set the Content-Type header to text/html
            self.send_header('Content-type', 'text/html')
            # End the headers
            self.end_headers()
            # Open the HTML file and read its content
            with open('/var/www/html/index.html', 'rb') as f:
                # Send the HTML content as the response body
                self.wfile.write(f.read())
        else:
            # If the path is not '/', send a 404 Not Found response
            self.send_error(404)

# Create an HTTPS server with the custom request handler
httpd = http.server.HTTPServer(('0.0.0.0', 4242), SimpleHTTPRequestHandler)

# Load the SSL certificate and key
httpd.socket = ssl.wrap_socket(httpd.socket, certfile='/etc/ssl/node/static_cert.crt', keyfile='/etc/ssl/node/static_cert.key', server_side=True)

# Start the server and keep it running
httpd.serve_forever()
