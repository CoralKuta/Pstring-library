#include <stdio.h>
#include "pstring.h"

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

void run_func(int opt, Pstring* p1, Pstring* p2) {
    switch (opt) {
        case 50:
        case 60:
            int len1 = pstrlen(p1);
            int len2 = pstrlen(p2);
            printf("first pstring length:%d, second pstring length:%d\n", len1, len2);

        case 52:
            char oldChar;
            char newChar;
            scanf("%c", &oldChar);
            scanf("%c", &newChar);

            int len1 = p1->len;
            int len2 = p2->len;

            for (int i = 0; i < len1; i++) {
                if (p1[i] == oldChar) {
                    p1[i] = newChar;
                }
            }

            for (int i = 0; i < len2; i++) {
                if (p2[i] == oldChar) {
                    p2[i] = newChar;
                }
            }
            printf("old char:%c, new char:%c, first string:%s, second string:%s\n", oldChar, newChar, p1, p2);

        case 53:
            int start;
            int end;
            scanf("%d", &start);
            scanf("%d", &end);

            Pstring dest = pstrijcpy(p1, p2, start, end);
            printf("length: %d,string: %s\n", pstrlen(dest), dest);
            printf("length: %d,string: %s\n", pstrlen(p2), p2);

        case 54:
            Pstring pstring1 = swapCase(p1);
            Pstring pstring2 = swapCase(p2);
            printf("length: %d,string: %s\n", pstrlen(pstring1), pstring1);
            printf("length: %d,string: %s\n", pstrlen(pstring2), pstring2);

        case 55:
            int start;
            int end;
            scanf("%d", &start);
            scanf("%d", &end);


    }

}
