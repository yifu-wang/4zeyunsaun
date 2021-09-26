//
//  main.m
//  简单运算
//
//  Created by Yep on 2021/9/25.


#import <Foundation/Foundation.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define MAXSIZE 1000
typedef struct {
    char s[1000];
    int top;
}Stack;

char top(Stack *p) {
    if (p->top == 0) {
        return '/0';
    }
    else
//        --(p->top);
        return p->s[p->top - 1];
}

int empyt(Stack *p) {
    return p->top == 0;
}

void push(Stack *p , char b) {
    p->s[p->top] = b;
    ++p->top;
}

char pop(Stack *p) {
    if (p->top == 0)
        printf("这是一个空栈");

    else
        --(p->top);
        return  p->s[p->top];
}

int compare(char s) {
    int i;
    switch (s) {
        case'+':
            i = 1;
            break;
        case'-':
            i = 1;
            break;
        case'*':
            i = 2;
            break;
        case'/':
            i = 2;
            break;

        default:
            i = 0;
            break;
    }
    return i;
}

void transform(float *a , float b, char c) {
    if (c == '-') {
        (*a) -= b;
    } else if (c == '+') {
        (*a) += b;

    } else if (c == '*') {
        (*a) *= b;
    } else {
        (*a) /= b;
    }
}

void operation(char *zhi) {
    int i = 0;
    Stack *ysfz = (Stack *)malloc(sizeof(Stack));
    ysfz->top = 0;
    float num[100];
    int n = 0;
//    printf("后缀表达式为:");
    while (zhi[i] != '=') {
        if (zhi[i] == '\0') {
            printf("没有=号");
            return;
        }
        if (zhi[i] <= '9' && zhi[i] >= '0') {
            num[++n] = 0;
            while (zhi[i] <= '9' && zhi[i] >= '0')  {
                num[n] *= 10;
                num[n] += (zhi[i] - '0');
                ++i;
            }
            if (zhi[i] == '.') {
                double f = 0.1;
                ++i;
                while (zhi[i] <= '9' && zhi[i] >= '0') {
                    num[n] += ((zhi[i] - '0') * f);
                    f *= 0.1;
                    ++i;
                }
            }
        } else {
            if (empyt(ysfz))
                push(ysfz, zhi[i]);
            else {
                if (zhi[i] == '(')
                    push(ysfz, zhi[i]);
                else if (zhi[i] == ')')
                {
                    while (top(ysfz) != '(') {
                        transform(&num[n - 1], num[n], top(ysfz));
//                        printf("%c", pop(ysfz));
                        pop(ysfz);

                        --n;
                    }
                    pop(ysfz);
                }
                else
                {
                    while (compare(zhi[i]) <= compare(top(ysfz)))
                    {
                        transform(&num[n - 1], num[n], top(ysfz));
//                        printf("%c", pop(ysfz));
                        pop(ysfz);
                        --n;
                    }
                    push(ysfz, zhi[i]);
                }

            }
            ++i;
        }

    }
    while (!empyt(ysfz)) {
        transform(&num[n - 1], num[n], top(ysfz));
//        printf("%c", pop(ysfz));
        pop(ysfz);
        --n;
    }
    printf("\n运算结果等于:%.2f\n", num[1]);

}
int main() {
        Stack *p;
        char zhi[50];
        scanf("%s", zhi);
        operation(zhi);
        return 0;
}

