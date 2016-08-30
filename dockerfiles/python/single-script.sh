python_version=3
script=script.py
instance_name=single-python-script

docker run -it --rm \
    --name $instance_name \
    -v "$PWD":/usr/src/myapp \
    -w /usr/src/myapp python:$python_version \
    python $script
