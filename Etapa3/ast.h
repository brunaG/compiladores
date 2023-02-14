#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

typedef struct ValorLexico{
    	int line_number;
    	char* tipo_token;
    	char* valor_token;	
    	union{
    		int lit_int;
    		float lit_float;
    		char lit_char;
    		bool lit_bool;
    	};
	
     }ValorLexico;

typedef struct Lista{
    struct Node* child;
    struct Lista* next;   
}Lista;


typedef struct Node{
    char* label;
    ValorLexico valor_lexico;
    Lista* child;
}Node;

Node* create_node(ValorLexico valor_lexico, int tipo, char* lexema);

void add_lista(Lista *lista, Node *node);

void add_child(Node *node, Node *child);


