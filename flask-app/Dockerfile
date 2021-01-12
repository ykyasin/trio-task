#Use Python Image
FROM python:latest
# Install apt dependencies
 
# Copy contents into image
 COPY . .
# run pip dependencies
 RUN pip install flask flask_sqlalchemy pymysql
# Expose correct port
EXPOSE 5000
# Create an entrypoint
ENTRYPOINT ["python3","app.py"]
