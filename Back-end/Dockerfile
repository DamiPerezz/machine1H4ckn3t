FROM python:3.9-slim

# Crea el directorio de la API
RUN mkdir -p /home/miAPI


COPY . /home/miAPI

RUN pip install --no-cache-dir flask

RUN pip install --no-cache-dir flask-cors


# Expone el puerto 5050
EXPOSE 5050

# Ejecuta la API
CMD ["python", "/home/miAPI/api-cmd.py"]