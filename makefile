BUILD = dart compile exe

RUN = dart run

FLAGS = -o ost

FILE = test.dart

build:
	${BUILD} ${FLAGS} ${FILE}

run:
	${RUN} ${FILE}