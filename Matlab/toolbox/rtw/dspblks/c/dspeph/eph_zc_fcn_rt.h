/*
 * @(#)eph_zc_fcn_rt.h    generated by: makeheader 4.21  Tue Mar 30 16:43:17 2004
 *
 *		built from:	eph_zc_fcn_rt.c
 */

#ifndef eph_zc_fcn_rt_h
#define eph_zc_fcn_rt_h

#ifdef __cplusplus
    extern "C" {
#endif

EXPORT_FCN EventPortEvent MWDSP_EPHZCFcn(EventPortMode      direction,
                                     EventPortSigState *prevSigStatePtr,
                                     EventPortSigState  currSigState);

#ifdef __cplusplus
    }	/* extern "C" */
#endif

#endif /* eph_zc_fcn_rt_h */