# To Optimize the docker layer caching we always need to follow the below order.
# System setup -- OS level dependencies.
     # base image setup
     # updating and installing the system level config
# Application setup -- Application dependencies
    # setup the workdir
    # copy the requirements to workdir
    # install the requirments
# Code setup --- copying the application and config
    # copy the code to workdir
# Runtime setup --- ports, cmd/entrypoint
    # expose and run the application


## stage1: buildtime
FROM python:3.11-slim as builder

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

RUN apt-get update && apt-get install -y build-essential \
    default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirments.txt .

RUN pip wheel --wheel-dir /wheels -r requirements.txt

## Stage2: runtime 
FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y libmariadb3

WORKDIR /app

COPY --from=builder /wheels /wheels

RUN pip install --no_cache_dir /wheels/*

COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
## CMD["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
## gunicorn -- production grade WSGI Http Server for python webapps
## --bind --- this will tells the gunicorn server to listen to all the network interfaces on port 5000. this is same like expose.
## app:app --- Module_name:Variable_name. ---module_name is name of the application ex: app.py. 
##             variable_name --- this the name we gave in the program for flask ie app = Flask(__name__)




