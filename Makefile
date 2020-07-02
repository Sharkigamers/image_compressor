##
## EPITECH PROJECT, 2020
## FUN_imageCompressor_2019
## File description:
## Makefile
##

NAME    =    imageCompressor

all:    $(NAME)

$(NAME):
		stack build && mv $(shell stack path --local-install-root)/bin/imageCompressor-exe ./
		mv imageCompressor-exe $(NAME)

clean:
		stack clean

fclean: clean
		rm -f $(NAME)

re:    fclean all

.PHONY: all clean fclean re