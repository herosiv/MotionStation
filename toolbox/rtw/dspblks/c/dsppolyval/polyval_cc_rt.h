/*
 * @(#)polyval_cc_rt.h    generated by: makeheader 4.21  Tue Mar 30 16:43:31 2004
 *
 *		built from:	polyval_cc_rt.c
 */

#ifndef polyval_cc_rt_h
#define polyval_cc_rt_h

#ifdef __cplusplus
    extern "C" {
#endif

EXPORT_FCN void MWDSP_polyval_CC(
    const creal32_T *u,          /* Input pointer */ 
          creal32_T *y,          /* Output pointer */ 
    const creal32_T *pCoeffs,    /* Pointer to coefficients */
    const int_T      N,          /* Number of coefficients */
    const int_T      n           /* Width of INPORT1*/ 
    );

#ifdef __cplusplus
    }	/* extern "C" */
#endif

#endif /* polyval_cc_rt_h */