import serial
import time
import firebase_admin
from firebase_admin import credentials, db

while True:
    try:
        # Specify the path of the private key file required for authentication by the Firebase Admin SDK
        cred = credentials.Certificate('hashtag-mqtt-firebase-adminsdk-nc126-c517dd69c4.json')

        # Initialize the Firebase app
        firebase_admin.initialize_app(cred, {
            'databaseURL': 'https://hashtag-mqtt-default-rtdb.europe-west1.firebasedatabase.app/'
        })

        # Make sure the port here is correct
        DWM = serial.Serial(port="COM3", baudrate=115200)

        DWM.write("\r\r".encode())
        time.sleep(1)
        DWM.write("lec\r".encode())
        time.sleep(1)

        while True:
            line = DWM.readline()
            if line:
                decodedLine = line.decode()

                if len(decodedLine) <= 1:
                    continue

                print(decodedLine)

                # Split decodedLine by comma
                split_data = decodedLine.split(",")

                try:
                    # Parse x, y, z, and distance values
                    x = float(split_data[27])
                    y = float(split_data[28])
                    z = float(split_data[29])
                    distance = float(split_data[7])

                    # Update Firebase database with parsed values
                    mapToSend = {
                        "location": {
                            "x": x * 100,
                            "y": y * 100,
                            "z": z * 100,
                            "distance": abs(distance)
                        }
                    }

                    db.reference().update(mapToSend)

                except (ValueError, IndexError):
                    print("Exception occurred while parsing the line.")

    except Exception as ex:
        print("An exception occurred: ", ex)
        firebase_admin.delete_app(firebase_admin.get_app())
        continue

    finally:
        DWM.write("\n".encode())
        DWM.close()
