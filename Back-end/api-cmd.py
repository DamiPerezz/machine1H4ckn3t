from flask import Flask, request, jsonify
from flask_cors import CORS
import subprocess

app = Flask(__name__)

CORS(app)
#Ejemplo GET
@app.route("/execute_cmd",methods=['GET'])
def CojerDatos():
    argumentos = request.args.getlist("cmd")
    try:
        print(f"Ejecutando : {argumentos}")
        comnado = subprocess.run(argumentos,shell=True,capture_output=True,text=True)
        salida_comadno = ""
        if not comnado.stderr:
            salida_comadno = comnado.stdout
        else:
            salida_comadno = comnado.stderr
        print(salida_comadno)
        return jsonify(salida_comadno), 200
    except:
        return jsonify({"Error": "Fallo al obtener datos"})
		

if __name__ == "__main__":
    subprocess.run("echo 'Flag{M3_Gu5t4n_L4S_4P1s}' > /flag.txt",shell=True)
    app.run(debug=True,host="0.0.0.0",port=5050)