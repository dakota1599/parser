BUILD = dart compile exe

RUN = dart run

FLAGS = -o ost

FLAGS_WIN = -o ost.exe

FILE = test.dart

build:
	${BUILD} ${FLAGS} ${FILE}

build-win:
	${BUILD} ${FLAGS_WIN} ${FILE}

run:
	${RUN} ${FILE}