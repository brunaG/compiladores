#include "ast.h"
#include "valor_lexico.h"
#include <stdio.h>
#include <stdlib.h>

Node *add_node(valorLexico valor_lexico)
{
    Node *node;
    node = malloc(sizeof(Nodo));

    node->child = NULL;
    node->irmao = NULL;
    node->valor_lexico = valor_lexico;

    return node;
}

add_child

void add_child(Node *node, Node *child)
{
    if(node!= NULL && child!=NULL)
    {
        if(node->child == NULL)
        {
            node->child = child;
        }
        else
        {
            //adicionar ultimo irmão
        }
    }
    return;
}