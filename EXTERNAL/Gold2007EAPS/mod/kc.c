/* Created by Language version: 7.7.0 */
/* VECTORIZED */
#define NRN_VECTORIZED 1
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "mech_api.h"
#undef PI
#define nil 0
#include "md1redef.h"
#include "section.h"
#include "nrniv_mf.h"
#include "md2redef.h"
 
#if METHOD3
extern int _method3;
#endif

#if !NRNGPU
#undef exp
#define exp hoc_Exp
extern double hoc_Exp(double);
#endif
 
#define nrn_init _nrn_init__kc
#define _nrn_initial _nrn_initial__kc
#define nrn_cur _nrn_cur__kc
#define _nrn_current _nrn_current__kc
#define nrn_jacob _nrn_jacob__kc
#define nrn_state _nrn_state__kc
#define _net_receive _net_receive__kc 
#define kin kin__kc 
#define rates rates__kc 
 
#define _threadargscomma_ _p, _ppvar, _thread, _nt,
#define _threadargsprotocomma_ double* _p, Datum* _ppvar, Datum* _thread, NrnThread* _nt,
#define _threadargs_ _p, _ppvar, _thread, _nt
#define _threadargsproto_ double* _p, Datum* _ppvar, Datum* _thread, NrnThread* _nt
 	/*SUPPRESS 761*/
	/*SUPPRESS 762*/
	/*SUPPRESS 763*/
	/*SUPPRESS 765*/
	 extern double *getarg();
 /* Thread safe. No static _p or _ppvar. */
 
#define t _nt->_t
#define dt _nt->_dt
#define gbar _p[0]
#define gbar_columnindex 0
#define C _p[1]
#define C_columnindex 1
#define O _p[2]
#define O_columnindex 2
#define I _p[3]
#define I_columnindex 3
#define ek _p[4]
#define ek_columnindex 4
#define cai _p[5]
#define cai_columnindex 5
#define ik _p[6]
#define ik_columnindex 6
#define roi _p[7]
#define roi_columnindex 7
#define ric _p[8]
#define ric_columnindex 8
#define roc _p[9]
#define roc_columnindex 9
#define rco _p[10]
#define rco_columnindex 10
#define DC _p[11]
#define DC_columnindex 11
#define DO _p[12]
#define DO_columnindex 12
#define DI _p[13]
#define DI_columnindex 13
#define v _p[14]
#define v_columnindex 14
#define _g _p[15]
#define _g_columnindex 15
#define _ion_ek	*_ppvar[0]._pval
#define _ion_ik	*_ppvar[1]._pval
#define _ion_dikdv	*_ppvar[2]._pval
#define _ion_cai	*_ppvar[3]._pval
 
#if MAC
#if !defined(v)
#define v _mlhv
#endif
#if !defined(h)
#define h _mlhh
#endif
#endif
 
#if defined(__cplusplus)
extern "C" {
#endif
 static int hoc_nrnpointerindex =  -1;
 static Datum* _extcall_thread;
 static Prop* _extcall_prop;
 /* external NEURON variables */
 /* declaration of user functions */
 static void _hoc_rate_tmax_fin(void);
 static void _hoc_rate_tmax_inf(void);
 static void _hoc_rates(void);
 static int _mechtype;
extern void _nrn_cacheloop_reg(int, int);
extern void hoc_register_prop_size(int, int, int);
extern void hoc_register_limits(int, HocParmLimits*);
extern void hoc_register_units(int, HocParmUnits*);
extern void nrn_promote(Prop*, int, int);
extern Memb_func* memb_func;
 
#define NMODL_TEXT 1
#if NMODL_TEXT
static const char* nmodl_file_text;
static const char* nmodl_filename;
extern void hoc_reg_nmodl_text(int, const char*);
extern void hoc_reg_nmodl_filename(int, const char*);
#endif

 extern void _nrn_setdata_reg(int, void(*)(Prop*));
 static void _setdata(Prop* _prop) {
 _extcall_prop = _prop;
 }
 static void _hoc_setdata() {
 Prop *_prop, *hoc_getdata_range(int);
 _prop = hoc_getdata_range(_mechtype);
   _setdata(_prop);
 hoc_retpushx(1.);
}
 /* connect user functions to hoc names */
 static VoidFunc hoc_intfunc[] = {
 "setdata_kc", _hoc_setdata,
 "rate_tmax_fin_kc", _hoc_rate_tmax_fin,
 "rate_tmax_inf_kc", _hoc_rate_tmax_inf,
 "rates_kc", _hoc_rates,
 0, 0
};
#define rate_tmax_fin rate_tmax_fin_kc
#define rate_tmax_inf rate_tmax_inf_kc
 extern double rate_tmax_fin( _threadargsprotocomma_ double , double , double , double , double );
 extern double rate_tmax_inf( _threadargsprotocomma_ double , double , double , double );
 /* declare global and static user variables */
#define alpha_co alpha_co_kc
 double alpha_co = 0;
#define k_co k_co_kc
 double k_co = 0;
#define k_oc k_oc_kc
 double k_oc = 0;
#define k_ic k_ic_kc
 double k_ic = 0;
#define k_oi k_oi_kc
 double k_oi = 0;
#define tmax_co tmax_co_kc
 double tmax_co = 0;
#define tmin_co tmin_co_kc
 double tmin_co = 0;
#define tmin_oc tmin_oc_kc
 double tmin_oc = 0;
#define tmin_ic tmin_ic_kc
 double tmin_ic = 0;
#define tmin_oi tmin_oi_kc
 double tmin_oi = 0;
#define vhalf_co vhalf_co_kc
 double vhalf_co = 0;
#define vhalf_oc vhalf_oc_kc
 double vhalf_oc = 0;
#define vhalf_ic vhalf_ic_kc
 double vhalf_ic = 0;
#define vhalf_oi vhalf_oi_kc
 double vhalf_oi = 0;
 /* some parameters have upper and lower limits */
 static HocParmLimits _hoc_parm_limits[] = {
 0,0,0
};
 static HocParmUnits _hoc_parm_units[] = {
 "k_oi_kc", "mV",
 "k_ic_kc", "mV",
 "k_co_kc", "mV",
 "k_oc_kc", "mV",
 "vhalf_oi_kc", "mV",
 "vhalf_ic_kc", "mV",
 "vhalf_co_kc", "mV",
 "vhalf_oc_kc", "mV",
 "tmin_oi_kc", "/ms",
 "tmin_ic_kc", "/ms",
 "tmin_co_kc", "/ms",
 "tmin_oc_kc", "/ms",
 "tmax_co_kc", "/ms",
 "alpha_co_kc", "/mM/mM/mM",
 "gbar_kc", "mho/cm2",
 0,0
};
 static double C0 = 0;
 static double I0 = 0;
 static double O0 = 0;
 static double delta_t = 0.01;
 /* connect global user variables to hoc */
 static DoubScal hoc_scdoub[] = {
 "k_oi_kc", &k_oi_kc,
 "k_ic_kc", &k_ic_kc,
 "k_co_kc", &k_co_kc,
 "k_oc_kc", &k_oc_kc,
 "vhalf_oi_kc", &vhalf_oi_kc,
 "vhalf_ic_kc", &vhalf_ic_kc,
 "vhalf_co_kc", &vhalf_co_kc,
 "vhalf_oc_kc", &vhalf_oc_kc,
 "tmin_oi_kc", &tmin_oi_kc,
 "tmin_ic_kc", &tmin_ic_kc,
 "tmin_co_kc", &tmin_co_kc,
 "tmin_oc_kc", &tmin_oc_kc,
 "tmax_co_kc", &tmax_co_kc,
 "alpha_co_kc", &alpha_co_kc,
 0,0
};
 static DoubVec hoc_vdoub[] = {
 0,0,0
};
 static double _sav_indep;
 static void nrn_alloc(Prop*);
static void  nrn_init(NrnThread*, _Memb_list*, int);
static void nrn_state(NrnThread*, _Memb_list*, int);
 static void nrn_cur(NrnThread*, _Memb_list*, int);
static void  nrn_jacob(NrnThread*, _Memb_list*, int);
 
static int _ode_count(int);
static void _ode_map(int, double**, double**, double*, Datum*, double*, int);
static void _ode_spec(NrnThread*, _Memb_list*, int);
static void _ode_matsol(NrnThread*, _Memb_list*, int);
 
#define _cvode_ieq _ppvar[4]._i
 static void _ode_matsol_instance1(_threadargsproto_);
 /* connect range variables in _p that hoc is supposed to know about */
 static const char *_mechanism[] = {
 "7.7.0",
"kc",
 "gbar_kc",
 0,
 0,
 "C_kc",
 "O_kc",
 "I_kc",
 0,
 0};
 static Symbol* _k_sym;
 static Symbol* _ca_sym;
 
extern Prop* need_memb(Symbol*);

static void nrn_alloc(Prop* _prop) {
	Prop *prop_ion;
	double *_p; Datum *_ppvar;
 	_p = nrn_prop_data_alloc(_mechtype, 16, _prop);
 	/*initialize range parameters*/
 	gbar = 0;
 	_prop->param = _p;
 	_prop->param_size = 16;
 	_ppvar = nrn_prop_datum_alloc(_mechtype, 5, _prop);
 	_prop->dparam = _ppvar;
 	/*connect ionic variables to this model*/
 prop_ion = need_memb(_k_sym);
 nrn_promote(prop_ion, 0, 1);
 	_ppvar[0]._pval = &prop_ion->param[0]; /* ek */
 	_ppvar[1]._pval = &prop_ion->param[3]; /* ik */
 	_ppvar[2]._pval = &prop_ion->param[4]; /* _ion_dikdv */
 prop_ion = need_memb(_ca_sym);
 nrn_promote(prop_ion, 1, 0);
 	_ppvar[3]._pval = &prop_ion->param[1]; /* cai */
 
}
 static void _initlists();
  /* some states have an absolute tolerance */
 static Symbol** _atollist;
 static HocStateTolerance _hoc_state_tol[] = {
 0,0
};
 static void _thread_cleanup(Datum*);
 static void _update_ion_pointer(Datum*);
 extern Symbol* hoc_lookup(const char*);
extern void _nrn_thread_reg(int, int, void(*)(Datum*));
extern void _nrn_thread_table_reg(int, void(*)(double*, Datum*, Datum*, NrnThread*, int));
extern void hoc_register_tolerance(int, HocStateTolerance*, Symbol***);
extern void _cvode_abstol( Symbol**, double*, int);

 void _kc_reg() {
	int _vectorized = 1;
  _initlists();
 	ion_reg("k", -10000.);
 	ion_reg("ca", -10000.);
 	_k_sym = hoc_lookup("k_ion");
 	_ca_sym = hoc_lookup("ca_ion");
 	register_mech(_mechanism, nrn_alloc,nrn_cur, nrn_jacob, nrn_state, nrn_init, hoc_nrnpointerindex, 3);
  _extcall_thread = (Datum*)ecalloc(2, sizeof(Datum));
 _mechtype = nrn_get_mechtype(_mechanism[1]);
     _nrn_setdata_reg(_mechtype, _setdata);
     _nrn_thread_reg(_mechtype, 0, _thread_cleanup);
     _nrn_thread_reg(_mechtype, 2, _update_ion_pointer);
 #if NMODL_TEXT
  hoc_reg_nmodl_text(_mechtype, nmodl_file_text);
  hoc_reg_nmodl_filename(_mechtype, nmodl_filename);
#endif
  hoc_register_prop_size(_mechtype, 16, 5);
  hoc_register_dparam_semantics(_mechtype, 0, "k_ion");
  hoc_register_dparam_semantics(_mechtype, 1, "k_ion");
  hoc_register_dparam_semantics(_mechtype, 2, "k_ion");
  hoc_register_dparam_semantics(_mechtype, 3, "ca_ion");
  hoc_register_dparam_semantics(_mechtype, 4, "cvodeieq");
 	hoc_register_cvode(_mechtype, _ode_count, _ode_map, _ode_spec, _ode_matsol);
 	hoc_register_tolerance(_mechtype, _hoc_state_tol, &_atollist);
 	hoc_register_var(hoc_scdoub, hoc_vdoub, hoc_intfunc);
 	ivoc_help("help ?1 kc kc.mod\n");
 hoc_register_limits(_mechtype, _hoc_parm_limits);
 hoc_register_units(_mechtype, _hoc_parm_units);
 }
static int _reset;
static char *modelname = "KC";

static int error;
static int _ninits = 0;
static int _match_recurse=1;
static void _modl_cleanup(){ _match_recurse=1;}
static int rates(_threadargsprotocomma_ double);
 extern double *_nrn_thread_getelm(SparseObj*, int, int);
 
#define _MATELM1(_row,_col) *(_nrn_thread_getelm(_so, _row + 1, _col + 1))
 
#define _RHS1(_arg) _rhs[_arg+1]
  
#define _linmat1  1
 static int _spth1 = 1;
 static int _cvspth1 = 0;
 
static int _ode_spec1(_threadargsproto_);
/*static int _ode_matsol1(_threadargsproto_);*/
 static int _slist1[3], _dlist1[3]; static double *_temp1;
 static int kin();
 
static int kin (void* _so, double* _rhs, double* _p, Datum* _ppvar, Datum* _thread, NrnThread* _nt)
 {int _reset=0;
 {
   double b_flux, f_flux, _term; int _i;
 {int _i; double _dt1 = 1.0/dt;
for(_i=1;_i<3;_i++){
  	_RHS1(_i) = -_dt1*(_p[_slist1[_i]] - _p[_dlist1[_i]]);
	_MATELM1(_i, _i) = _dt1;
      
} }
 rates ( _threadargscomma_ v ) ;
   /* ~ C <-> O ( rco , roc )*/
 f_flux =  rco * C ;
 b_flux =  roc * O ;
 _RHS1( 1) -= (f_flux - b_flux);
 _RHS1( 2) += (f_flux - b_flux);
 
 _term =  rco ;
 _MATELM1( 1 ,1)  += _term;
 _MATELM1( 2 ,1)  -= _term;
 _term =  roc ;
 _MATELM1( 1 ,2)  -= _term;
 _MATELM1( 2 ,2)  += _term;
 /*REACTION*/
  /* ~ O <-> I ( roi , 0.0 )*/
 f_flux =  roi * O ;
 b_flux =  0.0 * I ;
 _RHS1( 2) -= (f_flux - b_flux);
 
 _term =  roi ;
 _MATELM1( 2 ,2)  += _term;
 _term =  0.0 ;
 _MATELM1( 2 ,0)  -= _term;
 /*REACTION*/
  /* ~ I <-> C ( ric , 0.0 )*/
 f_flux =  ric * I ;
 b_flux =  0.0 * C ;
 _RHS1( 1) += (f_flux - b_flux);
 
 _term =  ric ;
 _MATELM1( 1 ,0)  -= _term;
 _term =  0.0 ;
 _MATELM1( 1 ,1)  += _term;
 /*REACTION*/
   /* C + O + I = 1.0 */
 _RHS1(0) =  1.0;
 _MATELM1(0, 0) = 1;
 _RHS1(0) -= I ;
 _MATELM1(0, 2) = 1;
 _RHS1(0) -= O ;
 _MATELM1(0, 1) = 1;
 _RHS1(0) -= C ;
 /*CONSERVATION*/
   } return _reset;
 }
 
static int  rates ( _threadargsprotocomma_ double _lv ) {
   roi = rate_tmax_inf ( _threadargscomma_ _lv , vhalf_oi , k_oi , tmin_oi ) ;
   ric = rate_tmax_inf ( _threadargscomma_ _lv , vhalf_ic , k_ic , tmin_ic ) ;
   roc = rate_tmax_inf ( _threadargscomma_ _lv , vhalf_oc , k_oc , tmin_oc ) ;
   rco = rate_tmax_fin ( _threadargscomma_ _lv , vhalf_co , k_co , tmin_co , tmax_co ) * alpha_co * pow( cai , 3.0 ) ;
    return 0; }
 
static void _hoc_rates(void) {
  double _r;
   double* _p; Datum* _ppvar; Datum* _thread; NrnThread* _nt;
   if (_extcall_prop) {_p = _extcall_prop->param; _ppvar = _extcall_prop->dparam;}else{ _p = (double*)0; _ppvar = (Datum*)0; }
  _thread = _extcall_thread;
  _nt = nrn_threads;
 _r = 1.;
 rates ( _p, _ppvar, _thread, _nt, *getarg(1) );
 hoc_retpushx(_r);
}
 
double rate_tmax_inf ( _threadargsprotocomma_ double _lv , double _lvhalf , double _lk , double _ltmin ) {
   double _lrate_tmax_inf;
 _lrate_tmax_inf = 1.0 / ( _ltmin + exp ( ( _lvhalf - _lv ) / _lk ) ) ;
   
return _lrate_tmax_inf;
 }
 
static void _hoc_rate_tmax_inf(void) {
  double _r;
   double* _p; Datum* _ppvar; Datum* _thread; NrnThread* _nt;
   if (_extcall_prop) {_p = _extcall_prop->param; _ppvar = _extcall_prop->dparam;}else{ _p = (double*)0; _ppvar = (Datum*)0; }
  _thread = _extcall_thread;
  _nt = nrn_threads;
 _r =  rate_tmax_inf ( _p, _ppvar, _thread, _nt, *getarg(1) , *getarg(2) , *getarg(3) , *getarg(4) );
 hoc_retpushx(_r);
}
 
double rate_tmax_fin ( _threadargsprotocomma_ double _lv , double _lvhalf , double _lk , double _ltmin , double _ltmax ) {
   double _lrate_tmax_fin;
 _lrate_tmax_fin = 1.0 / ( _ltmin + 1.0 / ( 1.0 / ( _ltmax - _ltmin ) + exp ( ( _lv - _lvhalf ) / _lk ) ) ) ;
   
return _lrate_tmax_fin;
 }
 
static void _hoc_rate_tmax_fin(void) {
  double _r;
   double* _p; Datum* _ppvar; Datum* _thread; NrnThread* _nt;
   if (_extcall_prop) {_p = _extcall_prop->param; _ppvar = _extcall_prop->dparam;}else{ _p = (double*)0; _ppvar = (Datum*)0; }
  _thread = _extcall_thread;
  _nt = nrn_threads;
 _r =  rate_tmax_fin ( _p, _ppvar, _thread, _nt, *getarg(1) , *getarg(2) , *getarg(3) , *getarg(4) , *getarg(5) );
 hoc_retpushx(_r);
}
 
/*CVODE ode begin*/
 static int _ode_spec1(double* _p, Datum* _ppvar, Datum* _thread, NrnThread* _nt) {int _reset=0;{
 double b_flux, f_flux, _term; int _i;
 {int _i; for(_i=0;_i<3;_i++) _p[_dlist1[_i]] = 0.0;}
 rates ( _threadargscomma_ v ) ;
 /* ~ C <-> O ( rco , roc )*/
 f_flux =  rco * C ;
 b_flux =  roc * O ;
 DC -= (f_flux - b_flux);
 DO += (f_flux - b_flux);
 
 /*REACTION*/
  /* ~ O <-> I ( roi , 0.0 )*/
 f_flux =  roi * O ;
 b_flux =  0.0 * I ;
 DO -= (f_flux - b_flux);
 DI += (f_flux - b_flux);
 
 /*REACTION*/
  /* ~ I <-> C ( ric , 0.0 )*/
 f_flux =  ric * I ;
 b_flux =  0.0 * C ;
 DI -= (f_flux - b_flux);
 DC += (f_flux - b_flux);
 
 /*REACTION*/
   /* C + O + I = 1.0 */
 /*CONSERVATION*/
   } return _reset;
 }
 
/*CVODE matsol*/
 static int _ode_matsol1(void* _so, double* _rhs, double* _p, Datum* _ppvar, Datum* _thread, NrnThread* _nt) {int _reset=0;{
 double b_flux, f_flux, _term; int _i;
   b_flux = f_flux = 0.;
 {int _i; double _dt1 = 1.0/dt;
for(_i=0;_i<3;_i++){
  	_RHS1(_i) = _dt1*(_p[_dlist1[_i]]);
	_MATELM1(_i, _i) = _dt1;
      
} }
 rates ( _threadargscomma_ v ) ;
 /* ~ C <-> O ( rco , roc )*/
 _term =  rco ;
 _MATELM1( 1 ,1)  += _term;
 _MATELM1( 2 ,1)  -= _term;
 _term =  roc ;
 _MATELM1( 1 ,2)  -= _term;
 _MATELM1( 2 ,2)  += _term;
 /*REACTION*/
  /* ~ O <-> I ( roi , 0.0 )*/
 _term =  roi ;
 _MATELM1( 2 ,2)  += _term;
 _MATELM1( 0 ,2)  -= _term;
 _term =  0.0 ;
 _MATELM1( 2 ,0)  -= _term;
 _MATELM1( 0 ,0)  += _term;
 /*REACTION*/
  /* ~ I <-> C ( ric , 0.0 )*/
 _term =  ric ;
 _MATELM1( 0 ,0)  += _term;
 _MATELM1( 1 ,0)  -= _term;
 _term =  0.0 ;
 _MATELM1( 0 ,1)  -= _term;
 _MATELM1( 1 ,1)  += _term;
 /*REACTION*/
   /* C + O + I = 1.0 */
 /*CONSERVATION*/
   } return _reset;
 }
 
/*CVODE end*/
 
static int _ode_count(int _type){ return 3;}
 
static void _ode_spec(NrnThread* _nt, _Memb_list* _ml, int _type) {
   double* _p; Datum* _ppvar; Datum* _thread;
   Node* _nd; double _v; int _iml, _cntml;
  _cntml = _ml->_nodecount;
  _thread = _ml->_thread;
  for (_iml = 0; _iml < _cntml; ++_iml) {
    _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
    _nd = _ml->_nodelist[_iml];
    v = NODEV(_nd);
  ek = _ion_ek;
  cai = _ion_cai;
     _ode_spec1 (_p, _ppvar, _thread, _nt);
  }}
 
static void _ode_map(int _ieq, double** _pv, double** _pvdot, double* _pp, Datum* _ppd, double* _atol, int _type) { 
	double* _p; Datum* _ppvar;
 	int _i; _p = _pp; _ppvar = _ppd;
	_cvode_ieq = _ieq;
	for (_i=0; _i < 3; ++_i) {
		_pv[_i] = _pp + _slist1[_i];  _pvdot[_i] = _pp + _dlist1[_i];
		_cvode_abstol(_atollist, _atol, _i);
	}
 }
 
static void _ode_matsol_instance1(_threadargsproto_) {
 _cvode_sparse_thread(&_thread[_cvspth1]._pvoid, 3, _dlist1, _p, _ode_matsol1, _ppvar, _thread, _nt);
 }
 
static void _ode_matsol(NrnThread* _nt, _Memb_list* _ml, int _type) {
   double* _p; Datum* _ppvar; Datum* _thread;
   Node* _nd; double _v; int _iml, _cntml;
  _cntml = _ml->_nodecount;
  _thread = _ml->_thread;
  for (_iml = 0; _iml < _cntml; ++_iml) {
    _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
    _nd = _ml->_nodelist[_iml];
    v = NODEV(_nd);
  ek = _ion_ek;
  cai = _ion_cai;
 _ode_matsol_instance1(_threadargs_);
 }}
 
static void _thread_cleanup(Datum* _thread) {
   _nrn_destroy_sparseobj_thread(_thread[_cvspth1]._pvoid);
   _nrn_destroy_sparseobj_thread(_thread[_spth1]._pvoid);
 }
 extern void nrn_update_ion_pointer(Symbol*, Datum*, int, int);
 static void _update_ion_pointer(Datum* _ppvar) {
   nrn_update_ion_pointer(_k_sym, _ppvar, 0, 0);
   nrn_update_ion_pointer(_k_sym, _ppvar, 1, 3);
   nrn_update_ion_pointer(_k_sym, _ppvar, 2, 4);
   nrn_update_ion_pointer(_ca_sym, _ppvar, 3, 1);
 }

static void initmodel(double* _p, Datum* _ppvar, Datum* _thread, NrnThread* _nt) {
  int _i; double _save;{
  C = C0;
  I = I0;
  O = O0;
 {
    _ss_sparse_thread(&_thread[_spth1]._pvoid, 3, _slist1, _dlist1, _p, &t, dt, kin, _linmat1, _ppvar, _thread, _nt);
     if (secondorder) {
    int _i;
    for (_i = 0; _i < 3; ++_i) {
      _p[_slist1[_i]] += dt*_p[_dlist1[_i]];
    }}
 }
 
}
}

static void nrn_init(NrnThread* _nt, _Memb_list* _ml, int _type){
double* _p; Datum* _ppvar; Datum* _thread;
Node *_nd; double _v; int* _ni; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
_thread = _ml->_thread;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
#if CACHEVEC
  if (use_cachevec) {
    _v = VEC_V(_ni[_iml]);
  }else
#endif
  {
    _nd = _ml->_nodelist[_iml];
    _v = NODEV(_nd);
  }
 v = _v;
  ek = _ion_ek;
  cai = _ion_cai;
 initmodel(_p, _ppvar, _thread, _nt);
 }
}

static double _nrn_current(double* _p, Datum* _ppvar, Datum* _thread, NrnThread* _nt, double _v){double _current=0.;v=_v;{ {
   ik = gbar * O * ( v - ek ) ;
   }
 _current += ik;

} return _current;
}

static void nrn_cur(NrnThread* _nt, _Memb_list* _ml, int _type) {
double* _p; Datum* _ppvar; Datum* _thread;
Node *_nd; int* _ni; double _rhs, _v; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
_thread = _ml->_thread;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
#if CACHEVEC
  if (use_cachevec) {
    _v = VEC_V(_ni[_iml]);
  }else
#endif
  {
    _nd = _ml->_nodelist[_iml];
    _v = NODEV(_nd);
  }
  ek = _ion_ek;
  cai = _ion_cai;
 _g = _nrn_current(_p, _ppvar, _thread, _nt, _v + .001);
 	{ double _dik;
  _dik = ik;
 _rhs = _nrn_current(_p, _ppvar, _thread, _nt, _v);
  _ion_dikdv += (_dik - ik)/.001 ;
 	}
 _g = (_g - _rhs)/.001;
  _ion_ik += ik ;
#if CACHEVEC
  if (use_cachevec) {
	VEC_RHS(_ni[_iml]) -= _rhs;
  }else
#endif
  {
	NODERHS(_nd) -= _rhs;
  }
 
}
 
}

static void nrn_jacob(NrnThread* _nt, _Memb_list* _ml, int _type) {
double* _p; Datum* _ppvar; Datum* _thread;
Node *_nd; int* _ni; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
_thread = _ml->_thread;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml];
#if CACHEVEC
  if (use_cachevec) {
	VEC_D(_ni[_iml]) += _g;
  }else
#endif
  {
     _nd = _ml->_nodelist[_iml];
	NODED(_nd) += _g;
  }
 
}
 
}

static void nrn_state(NrnThread* _nt, _Memb_list* _ml, int _type) {
double* _p; Datum* _ppvar; Datum* _thread;
Node *_nd; double _v = 0.0; int* _ni; int _iml, _cntml;
double _dtsav = dt;
if (secondorder) { dt *= 0.5; }
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
_thread = _ml->_thread;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
 _nd = _ml->_nodelist[_iml];
#if CACHEVEC
  if (use_cachevec) {
    _v = VEC_V(_ni[_iml]);
  }else
#endif
  {
    _nd = _ml->_nodelist[_iml];
    _v = NODEV(_nd);
  }
 v=_v;
{
  ek = _ion_ek;
  cai = _ion_cai;
 {  sparse_thread(&_thread[_spth1]._pvoid, 3, _slist1, _dlist1, _p, &t, dt, kin, _linmat1, _ppvar, _thread, _nt);
     if (secondorder) {
    int _i;
    for (_i = 0; _i < 3; ++_i) {
      _p[_slist1[_i]] += dt*_p[_dlist1[_i]];
    }}
 } }}
 dt = _dtsav;
}

static void terminal(){}

static void _initlists(){
 double _x; double* _p = &_x;
 int _i; static int _first = 1;
  if (!_first) return;
 _slist1[0] = I_columnindex;  _dlist1[0] = DI_columnindex;
 _slist1[1] = C_columnindex;  _dlist1[1] = DC_columnindex;
 _slist1[2] = O_columnindex;  _dlist1[2] = DO_columnindex;
_first = 0;
}

#if defined(__cplusplus)
} /* extern "C" */
#endif

#if NMODL_TEXT
static const char* nmodl_filename = "kc.mod";
static const char* nmodl_file_text = 
  ": Copyright (c) California Institute of Technology, 2006 -- All Rights Reserved\n"
  ": Royalty free license granted for non-profit research and educational purposes.\n"
  "\n"
  "TITLE KC\n"
  ": Ca dependent K current, Ic\n"
  ": Model from Borg-Graham 1999 & Shao et. al. 1999\n"
  "\n"
  "\n"
  "NEURON {\n"
  "	SUFFIX kc\n"
  "	\n"
  "	USEION k  READ ek WRITE ik\n"
  "	USEION ca READ cai\n"
  "	\n"
  "	RANGE  gbar\n"
  "	\n"
  "	GLOBAL k_oi, vhalf_oi, tmin_oi\n"
  "	GLOBAL k_ic, vhalf_ic, tmin_ic\n"
  "	GLOBAL k_oc, vhalf_oc, tmin_oc\n"
  "	GLOBAL k_co, vhalf_co, tmin_co, tmax_co, alpha_co\n"
  "}\n"
  "\n"
  "UNITS {\n"
  "	(mA) = (milliamp)\n"
  "	(mV) = (millivolt)\n"
  "	(molar) = (1/liter)\n"
  "	(mM) =	(millimolar)\n"
  "}\n"
  "\n"
  "ASSIGNED {\n"
  "\n"
  "        v       (mV)\n"
  "	ek      (mV)\n"
  "        cai	(mM)\n"
  "	ik	(mA/cm2)\n"
  "	\n"
  "	roi	(/ms)\n"
  "	ric	(/ms)\n"
  "	roc	(/ms)\n"
  "	rco	(/ms)\n"
  "\n"
  "}\n"
  "\n"
  "\n"
  ": default all params to zero and set them from hoc!\n"
  "\n"
  "\n"
  "PARAMETER {\n"
  "        gbar	= 0 (mho/cm2)\n"
  "	\n"
  "	k_oi = 0 (mV)\n"
  "	k_ic = 0 (mV)\n"
  "	k_co = 0 (mV)\n"
  "	k_oc = 0 (mV)\n"
  "	\n"
  "	vhalf_oi = 0 (mV)\n"
  "	vhalf_ic = 0 (mV)\n"
  "	vhalf_co = 0 (mV)\n"
  "	vhalf_oc = 0 (mV)\n"
  "	\n"
  "	tmin_oi = 0 (/ms)\n"
  "	tmin_ic = 0 (/ms)\n"
  "	tmin_co = 0 (/ms)\n"
  "	tmin_oc = 0 (/ms)\n"
  "	\n"
  "	tmax_co  = 0 (/ms)\n"
  "	alpha_co = 0 (/mM/mM/mM)\n"
  "}\n"
  "\n"
  "STATE { \n"
  "	C\n"
  "	O\n"
  "	I\n"
  "}\n"
  "\n"
  "BREAKPOINT { \n"
  "	SOLVE kin METHOD sparse\n"
  "	ik = gbar * O * ( v - ek ) \n"
  "}\n"
  "\n"
  "INITIAL {\n"
  "	SOLVE kin STEADYSTATE sparse\n"
  "}\n"
  "\n"
  "KINETIC kin {\n"
  "	rates(v)\n"
  "	\n"
  "	~ C<->O  (rco,roc)\n"
  "	~ O<->I  (roi,0.0)\n"
  "	~ I<->C  (ric,0.0)\n"
  "	\n"
  "	CONSERVE C + O + I = 1\n"
  "\n"
  "}\n"
  "\n"
  "PROCEDURE rates( v(mV)) {\n"
  "\n"
  "	 roi=rate_tmax_inf( v, vhalf_oi, k_oi, tmin_oi)\n"
  "	 ric=rate_tmax_inf( v, vhalf_ic, k_ic, tmin_ic)\n"
  "	 roc=rate_tmax_inf( v, vhalf_oc, k_oc, tmin_oc)\n"
  "	 \n"
  "	 \n"
  "	 rco=rate_tmax_fin( v, vhalf_co, k_co, tmin_co, tmax_co) *alpha_co* cai^3\n"
  "\n"
  "}\n"
  "\n"
  "\n"
  "FUNCTION rate_tmax_inf(  v, vhalf, k, tmin) {\n"
  "\n"
  "        rate_tmax_inf = 1.0/(tmin + exp((vhalf-v)/k))\n"
  "}\n"
  "\n"
  "\n"
  "FUNCTION rate_tmax_fin( v, vhalf, k, tmin, tmax ) {\n"
  "        \n"
  "	rate_tmax_fin = 1.0/(tmin + 1.0/(  1.0/(tmax-tmin) + exp((v-vhalf)/k) ))\n"
  "}\n"
  "\n"
  "\n"
  "\n"
  "\n"
  ;
#endif
