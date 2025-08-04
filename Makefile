CC = clang
CFLAGS = -Wall -g
LDFLAGS = -lobjc -framework Foundation -framework IOKit
SRCS = main.m
OBJS = $(SRCS:.m=.o)
TARGET = kbbfix

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(OBJS) -o $(TARGET) $(LDFLAGS)

%.o: %.m
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) kbbfix