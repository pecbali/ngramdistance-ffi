#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#ifdef NGRAM_CASE_INSENSITIVE
  #include <ctype.h>
  #define eq(x, y) (tolower(x) == tolower(y))
#else
  #define eq(x, y) ((x) == (y))
#endif

#ifndef max
  #define max( a, b ) ( ((a) > (b)) ? (a) : (b) )
#endif

#ifndef min
  #define min( a, b ) ( ((a) < (b)) ? (a) : (b) )
#endif


char* substring(const char* str, size_t begin, size_t len)
{
    if (str == 0 || strlen(str) == 0 || strlen(str) < begin || strlen(str) < (begin+len))
        return 0;
    
    return strndup(str + begin, len);
}


float ngramdistance (const char *source, const char *target,int n) {
    int sl = strlen(source);
    int tl = strlen(target);
    
    if (sl == 0 || tl == 0) {
        if (sl == tl) {
            return 1;
        }
        else {
            return 0;
        }
    }
    int cost = 0;
    if (sl < n || tl < n) {
        int ni = min(sl,tl);
        int i=0;
        for (i=0;i<ni;i++) {
            if (eq(source[i],target[i])) {
                cost++;
            }
        }
        return (float) cost/(float)max(sl, tl);
    }
    int char_len = sl+n-1;
    char* sa = calloc(char_len+1,sizeof(char));
      float* p; //'previous' cost array, horizontally
      float* d; // cost array, horizontally
      float* _d; //placeholder to assist in swapping p and d
      
      //construct sa with prefix
      int i=0;
      for (i=0;i<char_len;i++) {
          if (i < n-1) {
              sa[i]=0; //add prefix
          }
          else {
              sa[i] = source[i-n+1];
          }
      }
      int float_arr_len = sl+1;
      p = calloc( float_arr_len+1 , sizeof( float)); 
      d = calloc( float_arr_len+1 , sizeof( float)); 
      
      // indexes into strings s and t
      i=0; // iterates through source
      int j=0; // iterates through target
      
      char* t_j = calloc(n+1,sizeof(char)); // jth n-gram of t
      for (i = 0; i<=sl; i++) {
          p[i] = i;
      }
      
      for (j = 1; j<=tl; j++) {
          //construct t_j n-gram 
          if (j < n) {
              int ti=0;
              for (ti=0;ti<n-j;ti++) {
                  t_j[ti]=0; //add prefix
              }
              for (ti=n-j;ti<n;ti++) {
                  t_j[ti]=target[ti-(n-j)];
              }
          }
          else {
              free (t_j);
              t_j = substring(target,j-n, n);
          }
          d[0] = j;
          for (i=1; i<=sl; i++) {
              cost = 0;
              int tn=n;
              //compare sa to t_j
              int ni=0;
              for (ni=0;ni<n;ni++) {
                  if (!eq(sa[i-1+ni] , t_j[ni])) {
                      cost++;
                  }
                  else if (eq(sa[i-1+ni], 0)) { //discount matches on prefix
                      tn--;
                  }
              }
              float ec = (float) cost/(float)tn;
              // minimum of cell to the left+1, to the top+1, diagonally left and up +cost
              d[i] = min(min(d[i-1]+1, p[i]+1),  p[i-1]+ec);
          }
          // copy current distance counts to 'previous row' distance counts
          _d = p;
          p = d;
          d = _d;
      }
      float val = p[sl];
      free(p);
      free(d);
      free(t_j);
      free(sa);
      // our last action in the above loop was to switch d and p, so p now
      // actually has the most recent cost counts
      return 1.0f -  ((float) val / (float)max(tl, sl));
}


#ifdef TEST
#include <stdio.h>
#include "ngramdistance.h"
                      
  int main (int argc, char **argv) {
      float distance;
      if (argc < 3) return -1;
      distance = ngramdistance(argv[1], argv[2],3);
      printf("%s vs %s: %f\n", argv[1], argv[2],distance);
  }
#endif
