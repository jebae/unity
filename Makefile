CC = gcc

CFLAGS = -Wall -Wextra -Werror

INCLUDES = -I $(UNITY_PATH)/include

DEFINE = -D UNITY_INCLUDE_CONFIG_H

NAME = libunity.a

SRC_UNITY = unity.c
SRC_MEMORY = unity_memory.c
SRC_FIXTURE = unity_fixture.c

OBJS = $(SRC_UNITY:.c=.o)
OBJS += $(SRC_MEMORY:.c=.o)
OBJS += $(SRC_FIXTURE:.c=.o)

%.o : src/%.c
	$(CC) $(DEFINE) $(CFLAGS) $(INCLUDES) -c $^ -o $@

%.o : extras/memory/src/%.c
	$(CC) $(DEFINE) $(CFLAGS) $(INCLUDES) -c $^ -o $@

%.o : extras/fixture/src/%.c
	$(CC) $(DEFINE) $(CFLAGS) $(INCLUDES) -c $^ -o $@

all : $(NAME)

$(INCLUDES) :
	mkdir -p $(UNITY_PATH)/include
	cp $(UNITY_PATH)/src/*.h $(UNITY_PATH)/include
	cp $(UNITY_PATH)/extras/memory/src/*.h $(UNITY_PATH)/include
	cp $(UNITY_PATH)/extras/fixture/src/*.h $(UNITY_PATH)/include
	cp $(UNITY_PATH)/examples/*.h $(UNITY_PATH)/include

$(NAME) : $(INCLUDES) $(OBJS)
	ar rc $(NAME) $(OBJS)
	ranlib $(NAME)
	mkdir -p $(UNITY_PATH)/lib
	mv $(NAME) $(UNITY_PATH)/lib/

clean :
	rm -rf $(OBJS)

fclean : clean
	rm -rf include
	rm -rf lib

re : fclean all

.PHONY : all clean fclean re
