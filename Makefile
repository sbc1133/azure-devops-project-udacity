install:
    pip install --upgrade pip &&\
        pip install -r requirements.txt

lint:
    pylint --disable=R,C hello.py

test:
    pytest -vv --disable-warnings --maxfail=1

all: install lint test