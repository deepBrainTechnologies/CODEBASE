#include <stdio.h>
#include "hocdec.h"
#define IMPORT extern __declspec(dllimport)
IMPORT int nrnmpi_myid, nrn_nobanner_;

extern void _cadif_reg();
extern void _cal_reg();
extern void _can_reg();
extern void _car_reg();
extern void _cat_reg();
extern void _hdend_reg();
extern void _hsoma_reg();
extern void _kadist_reg();
extern void _kahp_reg();
extern void _kaprox_reg();
extern void _kc_reg();
extern void _kd_reg();
extern void _kk_reg();
extern void _km_reg();
extern void _naf_reg();
extern void _nax_reg();

void modl_reg(){
	//nrn_mswindll_stdio(stdin, stdout, stderr);
    if (!nrn_nobanner_) if (nrnmpi_myid < 1) {
	fprintf(stderr, "Additional mechanisms from files\n");

fprintf(stderr," cadif.mod");
fprintf(stderr," cal.mod");
fprintf(stderr," can.mod");
fprintf(stderr," car.mod");
fprintf(stderr," cat.mod");
fprintf(stderr," hdend.mod");
fprintf(stderr," hsoma.mod");
fprintf(stderr," kadist.mod");
fprintf(stderr," kahp.mod");
fprintf(stderr," kaprox.mod");
fprintf(stderr," kc.mod");
fprintf(stderr," kd.mod");
fprintf(stderr," kk.mod");
fprintf(stderr," km.mod");
fprintf(stderr," naf.mod");
fprintf(stderr," nax.mod");
fprintf(stderr, "\n");
    }
_cadif_reg();
_cal_reg();
_can_reg();
_car_reg();
_cat_reg();
_hdend_reg();
_hsoma_reg();
_kadist_reg();
_kahp_reg();
_kaprox_reg();
_kc_reg();
_kd_reg();
_kk_reg();
_km_reg();
_naf_reg();
_nax_reg();
}
