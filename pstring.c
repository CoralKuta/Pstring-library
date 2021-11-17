//
// Created by coral on 16/11/2021.
//
#include "pstring.h"


char pstrlen(Pstring* pstr) {
    return pstr->len;
}


Pstring* replaceChar(Pstring* pstr, char oldChar, char newChar) {
    int len = (int)pstr->len;

    for (int i = 0; i < len; i++) {
        if (pstr->str[i] == oldChar) {
            pstr->str[i] = newChar;
        }
    }
}


Pstring* pstrijcpy(Pstring* dst, Pstring* src, char i, char j) {
    // j is the end, i is the start



}

Pstring* swapCase(Pstring* pstr) {
    int len = (int)pstrlen(pstr);
    for (int i = 0; i < len; i++) {
        // upper case to lower case
        if ((pstr->str[i] >= 65) && (pstr->str[i] <= 90)) {
            pstr->str[i] = pstr->str[i] + 32;
            // lower case to upper case
        } else if ((pstr->str[i] >= 97) && (pstr->str[i] <= 122)) {
            pstr->str[i] = pstr->str[i] - 32;
        }
    }
    //not doing anything to the rest of the characters
    return pstr;

}

int pstrijcmp(Pstring* pstr1, Pstring* psrt2, char i, char j) {

}

