#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "ast.h"

Node* create_node(ValorLexico valor_lexico, int tipo, char* lexema)
{
    Node *node;
    node = malloc(sizeof(Node));

    char* temp;
    
    node->child = NULL;
    node->valor_lexico = valor_lexico;
  
    
    if(tipo == 0){
        node->label = strdup(lexema);
    }else if(tipo == 1){
        node->label = strdup("<=");   
    }else if(tipo == 2){
    	node->label = strdup("=");
    }else if(tipo == 3){
    	node->label = strdup("[]");
    }else if(tipo == 4){
    	node->label = strdup("^");
    }else if(tipo == 5){
    	node->label = strdup("call");
    }else if(tipo == 6){
    	node->label = strdup("return");
    }else if(tipo == 7){
    	node->label = strdup("if");
    }else if(tipo == 8){
    	node->label = strdup("while");
    }else if(tipo == 9){
    	node->label = strdup(valor_lexico.valor_token);
    }else if(tipo == 10){
        node->label = strdup("||");
    }else if(tipo == 11){
        node->label = strdup("&&");
    }else if(tipo == 12){
    	char str[2] = "\0";
    	str[0] = valor_lexico.lit_char; 
    	strcpy(node->label,str);
    }
    
    return node;
}

void add_lista(Lista *lista, Node *node){

	Lista *novoNodo = malloc(sizeof(Lista));
	Lista *run = lista; 
	
	
	while(run->next != NULL){
		run = run->next;
	}
	
	
	run->next = novoNodo;
	novoNodo->next = NULL;
	novoNodo->child = node;	
	return;	
}

void add_child(Node *node, Node *child)
{
    if(node->child == NULL)
    {
         Lista *lista;
         lista = malloc(sizeof(Lista));
         lista->next = NULL;
         lista->child = child;	
         node->child = lista;
    }
    else
    {
        add_lista(node->child,child);    
    }
      
    return;
}

void exporta (void *arvore){
	if(arvore == NULL)
		return;
				
        Node *node = arvore;
	Lista *tempN;	
	Lista *tempL = node->child;
	
	printf("%p [label=\"%s\"];\n",arvore,node->label);
	
	if(tempL != NULL){
		tempN = tempL;
		do{
			printf("%p, %p\n",arvore,tempN->child);
			exporta(tempN->child);
			tempN = tempN->next;
		}while(tempN != NULL);				
	}
 	return;
}

void libera(void *arvore){
	if(arvore == NULL)
		return;
				
        Node *node = arvore;
	Lista *tempN,*tempDel;	
	Lista *tempL = node->child;

	if(tempL != NULL){
		tempN = tempL;
		do{
			exporta(tempN->child);
			tempDel = tempN;
			tempN = tempN->next;
			free(tempDel);	
		}while(tempN != NULL);
						
	}
		
	free(node->label);
	free(node);
	
	return;
}
