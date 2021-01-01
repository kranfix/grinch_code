CC=gcc
exe=phil

c: ${exe}
	./${exe}


${exe}: src/main.c
	${CC} -o ${exe} src/main.c

.PHONY: clean

clean:
	rm -f ${exe}