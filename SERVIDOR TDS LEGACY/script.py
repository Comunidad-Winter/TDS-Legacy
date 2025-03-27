import socket
import urllib.parse
import os
import requests
from datetime import datetime

os.environ["PYTHONHTTPSVERIFY"] = "0"

host = "https://tdslegacy.net/cuentas/"

def get_url_mapping():
    return {
        0: host + '4gr3g4r_p3rs0n4j3.php',
        1: host + 'update_pj_mao.php',
        2: host + 'setonlines.php',
        #3: host + 'servertick.php',
        4: host + 'b0rr4r_p3rs0naj34.php',
        5: host + '4pd4t3_p3rs0n4j3.php',
        6: host + '4pd4t3_cl4n.php'
    }

def log_message(filename, message):
    with open(filename, 'a') as f:
        f.write(message)

def process_request(data, conn):
    try:
        tipo = data[1]
        if tipo == 'A':
            log_message('logDesarrollo.txt', data[2:])
        elif tipo == "B":
            log_message('logAsesinatos.txt', data[2:])
        elif tipo == "C":
            log_message('logAntiCheat.txt', data[2:])
        else:
            tipo = int(data[1])
            url = get_url_mapping()[tipo]
            data = data[2:]
            data_dict = dict(urllib.parse.parse_qsl(data))
            response = requests.post(url, data=data_dict)
            
            conn.sendall(response.text.encode('utf-8'))
    except Exception as e:
        log_message('error_log.txt', f"{datetime.now()} Error: {e} - DATA: {data}\n")

def main():
    vb6_sock_recv = socket.socket()
    vb6_sock_recv.bind(("127.0.0.1", 6667))
    vb6_sock_recv.listen(1)
    print("Listening on port 6667")

    while True:
        try:
            conn_vb6_recv, address = vb6_sock_recv.accept()
            print(f"Accepted connection from {address}")

            while True:
                data = conn_vb6_recv.recv(4096).decode("iso-8859-1", "ignore")
                if not data:
                    break

                if data[0] != "|":
                    conn_vb6_recv.sendall(data.encode('utf-8'))
                else:
                    requests = data.split("|")
                    for req in requests[1:]:
                        process_request("/" + req, conn_vb6_recv)
        except Exception as e:
            log_message('error_log.txt', f"{datetime.now()} Error: {e}\n")
        finally:
            conn_vb6_recv.close()

if __name__ == '__main__':
    main()