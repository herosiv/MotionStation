/*
 * @(#)allpole_tdf_cc_rt.h    generated by: makeheader 4.21  Tue Mar 30 16:43:12 2004
 *
 *		built from:	allpole_tdf_cc_rt.c
 */

#ifndef allpole_tdf_cc_rt_h
#define allpole_tdf_cc_rt_h

#ifdef __cplusplus
    extern "C" {
#endif

EXPORT_FCN void MWDSP_AllPole_TDF_CC(const creal32_T         *u,
                          creal32_T               *y,
                          creal32_T * const       mem_base,
                          const int_T             numDelays,
                          const int_T             sampsPerChan,
                          const int_T             numChans,
                          const creal32_T * const den,
                          const int_T             ordDEN,
                          const boolean_T         one_fpf);

#ifdef __cplusplus
    }	/* extern "C" */
#endif

#endif /* allpole_tdf_cc_rt_h */