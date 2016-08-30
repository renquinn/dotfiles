# Custom Image (with dependencies)

1. copy Dockerfile and Makefile to repo
2. change FROM in Dockerfile to match desired python version
3. create requirements.txt with necessary package dependencies
4. edit Makefile as needed
5. ```make build```
6. ```make```

# Single Script (no dependencies)

1. use single-script.sh
2. set python version, script name, and docker instance name
