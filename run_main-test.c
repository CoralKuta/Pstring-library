#include <stdio.h>
#include "pstring.h"


void run_func(int opt, Pstring* p1, Pstring* p2) {
    switch (opt) {
        case 50:
        case 60:{
            int len1 = (int)pstrlen(p1);
            int len2 = (int)pstrlen(p2);
            printf("first pstring length:%d, second pstring length:%d\n", len1, len2);
            break;
        }
        case 52:{
            char oldChar;
            char newChar;
            scanf(" %c", &oldChar);
            scanf(" %c", &newChar);

            replaceChar(p1, oldChar, newChar);
            replaceChar(p2, oldChar, newChar);

            printf("old char:%c, new char:%c, first string:%s, second string:%s\n", oldChar, newChar,
                   p1->str, p2->str);
            break;
        }
        case 53:{
            int start;
            int end;
            scanf("%d", &start);
            scanf("%d", &end);

            pstrijcpy(p1, p2, (char)start, (char)end);
            printf("length: %d,string: %s\n", pstrlen(p1), p1->str);
            printf("length: %d,string: %s\n", pstrlen(p2), p2->str);
            break;
        }
        case 54:{
            swapCase(p1);
            swapCase(p2);
            printf("length: %d,string: %s\n", pstrlen(p1), p1->str);
            printf("length: %d,string: %s\n", pstrlen(p2), p2->str);
            break;
        }
        case 55:{
            int start;
            int end;
            scanf("%d", &start);
            scanf("%d", &end);

            int result = pstrijcmp(p1, p2, (char)start, (char)end);
            printf("compare result: %d\n", result);
            break;
        }
        default:
            printf("invalid option!\n");
    }
}


void run_main() {
	Pstring p1;
	Pstring p2;
	int len;
	int opt;

	// initialize first pstring
	scanf("%d", &len);
	scanf("%s", p1.str);
	p1.len = len;

	// initialize second pstring
	scanf("%d", &len);
	scanf("%s", p2.str);
	p2.len = len;

	// select which function to run
	scanf("%d", &opt);
	run_func(opt, &p1, &p2);
}

