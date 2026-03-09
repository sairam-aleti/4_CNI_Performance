from http.server import BaseHTTPRequestHandler, HTTPServer
import socket

class RequestHandler(BaseHTTPRequestHandler):

    def do_GET(self):
        hostname = socket.gethostname()

        self.send_response(200)
        self.send_header("Content-type", "text/plain")
        self.end_headers()

        response = f"Hello from pod: {hostname}\n"
        self.wfile.write(response.encode())

if __name__ == "__main__":
    server_address = ("", 8080)
    httpd = HTTPServer(server_address, RequestHandler)

    print("Server started on port 8080")
    httpd.serve_forever()