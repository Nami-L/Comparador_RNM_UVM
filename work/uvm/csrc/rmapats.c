// file = 0; split type = patterns; threshold = 100000; total count = 0.
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include "rmapats.h"

void  schedNewEvent (struct dummyq_struct * I1418, EBLK  * I1413, U  I623);
void  schedNewEvent (struct dummyq_struct * I1418, EBLK  * I1413, U  I623)
{
    U  I1684;
    U  I1685;
    U  I1686;
    struct futq * I1687;
    struct dummyq_struct * pQ = I1418;
    I1684 = ((U )vcs_clocks) + I623;
    I1686 = I1684 & ((1 << fHashTableSize) - 1);
    I1413->I668 = (EBLK  *)(-1);
    I1413->I669 = I1684;
    if (0 && rmaProfEvtProp) {
        vcs_simpSetEBlkEvtID(I1413);
    }
    if (I1684 < (U )vcs_clocks) {
        I1685 = ((U  *)&vcs_clocks)[1];
        sched_millenium(pQ, I1413, I1685 + 1, I1684);
    }
    else if ((peblkFutQ1Head != ((void *)0)) && (I623 == 1)) {
        I1413->I671 = (struct eblk *)peblkFutQ1Tail;
        peblkFutQ1Tail->I668 = I1413;
        peblkFutQ1Tail = I1413;
    }
    else if ((I1687 = pQ->I1321[I1686].I691)) {
        I1413->I671 = (struct eblk *)I1687->I689;
        I1687->I689->I668 = (RP )I1413;
        I1687->I689 = (RmaEblk  *)I1413;
    }
    else {
        sched_hsopt(pQ, I1413, I1684);
    }
}
#ifdef __cplusplus
extern "C" {
#endif
void SinitHsimPats(void);
#ifdef __cplusplus
}
#endif
