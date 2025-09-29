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
 
#define nrn_init _nrn_init__naf
#define _nrn_initial _nrn_initial__naf
#define nrn_cur _nrn_cur__naf
#define _nrn_current _nrn_current__naf
#define nrn_jacob _nrn_jacob__naf
#define nrn_state _nrn_state__naf
#define _net_receive _net_receive__naf 
#define rates rates__naf 
#define states states__naf 
 
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
#define minf _p[1]
#define minf_columnindex 1
#define mtau _p[2]
#define mtau_columnindex 2
#define hinf _p[3]
#define hinf_columnindex 3
#define htau _p[4]
#define htau_columnindex 4
#define m _p[5]
#define m_columnindex 5
#define h _p[6]
#define h_columnindex 6
#define ena _p[7]
#define ena_columnindex 7
#define ina _p[8]
#define ina_columnindex 8
#define Dm _p[9]
#define Dm_columnindex 9
#define Dh _p[10]
#define Dh_columnindex 10
#define v _p[11]
#define v_columnindex 11
#define _g _p[12]
#define _g_columnindex 12
#define _ion_ena	*_ppvar[0]._pval
#define _ion_ina	*_ppvar[1]._pval
#define _ion_dinadv	*_ppvar[2]._pval
 
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
 extern double celsius;
 /* declaration of user functions */
 static void _hoc_rates(void);
 static void _hoc_var_tau(void);
 static void _hoc_var_inf(void);
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
 "setdata_naf", _hoc_setdata,
 "rates_naf", _hoc_rates,
 "var_tau_naf", _hoc_var_tau,
 "var_inf_naf", _hoc_var_inf,
 0, 0
};
#define var_tau var_tau_naf
#define var_inf var_inf_naf
 extern double var_tau( _threadargsprotocomma_ double , double , double , double , double , double );
 extern double var_inf( _threadargsprotocomma_ double , double , double );
 /* declare global and static user variables */
#define exp_h exp_h_naf
 double exp_h = 0;
#define exp_m exp_m_naf
 double exp_m = 0;
#define toffset_h toffset_h_naf
 double toffset_h = 0;
#define tscale_h tscale_h_naf
 double tscale_h = 0;
#define tskew_h tskew_h_naf
 double tskew_h = 0;
#define toffset_m toffset_m_naf
 double toffset_m = 0;
#define tscale_m tscale_m_naf
 double tscale_m = 0;
#define tskew_m tskew_m_naf
 double tskew_m = 0;
#define vsteep_h vsteep_h_naf
 double vsteep_h = 0;
#define vhalf_h vhalf_h_naf
 double vhalf_h = 0;
#define vsteep_m vsteep_m_naf
 double vsteep_m = 0;
#define vhalf_m vhalf_m_naf
 double vhalf_m = 0;
 /* some parameters have upper and lower limits */
 static HocParmLimits _hoc_parm_limits[] = {
 0,0,0
};
 static HocParmUnits _hoc_parm_units[] = {
 "vhalf_m_naf", "mV",
 "vsteep_m_naf", "mV",
 "tscale_m_naf", "ms",
 "toffset_m_naf", "ms",
 "vhalf_h_naf", "mV",
 "vsteep_h_naf", "mV",
 "tscale_h_naf", "ms",
 "toffset_h_naf", "ms",
 "gbar_naf", "mho/cm2",
 0,0
};
 static double delta_t = 0.01;
 static double h0 = 0;
 static double m0 = 0;
 /* connect global user variables to hoc */
 static DoubScal hoc_scdoub[] = {
 "vhalf_m_naf", &vhalf_m_naf,
 "vsteep_m_naf", &vsteep_m_naf,
 "tskew_m_naf", &tskew_m_naf,
 "tscale_m_naf", &tscale_m_naf,
 "toffset_m_naf", &toffset_m_naf,
 "exp_m_naf", &exp_m_naf,
 "vhalf_h_naf", &vhalf_h_naf,
 "vsteep_h_naf", &vsteep_h_naf,
 "tskew_h_naf", &tskew_h_naf,
 "tscale_h_naf", &tscale_h_naf,
 "toffset_h_naf", &toffset_h_naf,
 "exp_h_naf", &exp_h_naf,
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
 
#define _cvode_ieq _ppvar[3]._i
 static void _ode_matsol_instance1(_threadargsproto_);
 /* connect range variables in _p that hoc is supposed to know about */
 static const char *_mechanism[] = {
 "7.7.0",
"naf",
 "gbar_naf",
 0,
 "minf_naf",
 "mtau_naf",
 "hinf_naf",
 "htau_naf",
 0,
 "m_naf",
 "h_naf",
 0,
 0};
 static Symbol* _na_sym;
 
extern Prop* need_memb(Symbol*);

static void nrn_alloc(Prop* _prop) {
	Prop *prop_ion;
	double *_p; Datum *_ppvar;
 	_p = nrn_prop_data_alloc(_mechtype, 13, _prop);
 	/*initialize range parameters*/
 	gbar = 0;
 	_prop->param = _p;
 	_prop->param_size = 13;
 	_ppvar = nrn_prop_datum_alloc(_mechtype, 4, _prop);
 	_prop->dparam = _ppvar;
 	/*connect ionic variables to this model*/
 prop_ion = need_memb(_na_sym);
 nrn_promote(prop_ion, 0, 1);
 	_ppvar[0]._pval = &prop_ion->param[0]; /* ena */
 	_ppvar[1]._pval = &prop_ion->param[3]; /* ina */
 	_ppvar[2]._pval = &prop_ion->param[4]; /* _ion_dinadv */
 
}
 static void _initlists();
  /* some states have an absolute tolerance */
 static Symbol** _atollist;
 static HocStateTolerance _hoc_state_tol[] = {
 0,0
};
 static void _update_ion_pointer(Datum*);
 extern Symbol* hoc_lookup(const char*);
extern void _nrn_thread_reg(int, int, void(*)(Datum*));
extern void _nrn_thread_table_reg(int, void(*)(double*, Datum*, Datum*, NrnThread*, int));
extern void hoc_register_tolerance(int, HocStateTolerance*, Symbol***);
extern void _cvode_abstol( Symbol**, double*, int);

 void _naf_reg() {
	int _vectorized = 1;
  _initlists();
 	ion_reg("na", -10000.);
 	_na_sym = hoc_lookup("na_ion");
 	register_mech(_mechanism, nrn_alloc,nrn_cur, nrn_jacob, nrn_state, nrn_init, hoc_nrnpointerindex, 1);
 _mechtype = nrn_get_mechtype(_mechanism[1]);
     _nrn_setdata_reg(_mechtype, _setdata);
     _nrn_thread_reg(_mechtype, 2, _update_ion_pointer);
 #if NMODL_TEXT
  hoc_reg_nmodl_text(_mechtype, nmodl_file_text);
  hoc_reg_nmodl_filename(_mechtype, nmodl_filename);
#endif
  hoc_register_prop_size(_mechtype, 13, 4);
  hoc_register_dparam_semantics(_mechtype, 0, "na_ion");
  hoc_register_dparam_semantics(_mechtype, 1, "na_ion");
  hoc_register_dparam_semantics(_mechtype, 2, "na_ion");
  hoc_register_dparam_semantics(_mechtype, 3, "cvodeieq");
 	hoc_register_cvode(_mechtype, _ode_count, _ode_map, _ode_spec, _ode_matsol);
 	hoc_register_tolerance(_mechtype, _hoc_state_tol, &_atollist);
 	hoc_register_var(hoc_scdoub, hoc_vdoub, hoc_intfunc);
 	ivoc_help("help ?1 naf naf.mod\n");
 hoc_register_limits(_mechtype, _hoc_parm_limits);
 hoc_register_units(_mechtype, _hoc_parm_units);
 }
static int _reset;
static char *modelname = "Fast NA";

static int error;
static int _ninits = 0;
static int _match_recurse=1;
static void _modl_cleanup(){ _match_recurse=1;}
static int rates(_threadargsprotocomma_ double);
 
static int _ode_spec1(_threadargsproto_);
/*static int _ode_matsol1(_threadargsproto_);*/
 static int _slist1[2], _dlist1[2];
 static int states(_threadargsproto_);
 
/*CVODE*/
 static int _ode_spec1 (double* _p, Datum* _ppvar, Datum* _thread, NrnThread* _nt) {int _reset = 0; {
   rates ( _threadargscomma_ v ) ;
   Dm = ( minf - m ) / mtau ;
   Dh = ( hinf - h ) / htau ;
   }
 return _reset;
}
 static int _ode_matsol1 (double* _p, Datum* _ppvar, Datum* _thread, NrnThread* _nt) {
 rates ( _threadargscomma_ v ) ;
 Dm = Dm  / (1. - dt*( ( ( ( - 1.0 ) ) ) / mtau )) ;
 Dh = Dh  / (1. - dt*( ( ( ( - 1.0 ) ) ) / htau )) ;
  return 0;
}
 /*END CVODE*/
 static int states (double* _p, Datum* _ppvar, Datum* _thread, NrnThread* _nt) { {
   rates ( _threadargscomma_ v ) ;
    m = m + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / mtau)))*(- ( ( ( minf ) ) / mtau ) / ( ( ( ( - 1.0 ) ) ) / mtau ) - m) ;
    h = h + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / htau)))*(- ( ( ( hinf ) ) / htau ) / ( ( ( ( - 1.0 ) ) ) / htau ) - h) ;
   }
  return 0;
}
 
static int  rates ( _threadargsprotocomma_ double _lv ) {
   minf = var_inf ( _threadargscomma_ _lv , vhalf_m , vsteep_m ) ;
   hinf = var_inf ( _threadargscomma_ _lv , vhalf_h , vsteep_h ) ;
   mtau = var_tau ( _threadargscomma_ _lv , vhalf_m , vsteep_m , tskew_m , tscale_m , toffset_m ) ;
   htau = var_tau ( _threadargscomma_ _lv , vhalf_h , vsteep_h , tskew_h , tscale_h , toffset_h ) ;
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
 
double var_inf ( _threadargsprotocomma_ double _lv , double _lvhalf , double _lvsteep ) {
   double _lvar_inf;
 _lvar_inf = 1.0 / ( 1.0 + exp ( ( _lv - _lvhalf ) / ( _lvsteep ) ) ) ;
   
return _lvar_inf;
 }
 
static void _hoc_var_inf(void) {
  double _r;
   double* _p; Datum* _ppvar; Datum* _thread; NrnThread* _nt;
   if (_extcall_prop) {_p = _extcall_prop->param; _ppvar = _extcall_prop->dparam;}else{ _p = (double*)0; _ppvar = (Datum*)0; }
  _thread = _extcall_thread;
  _nt = nrn_threads;
 _r =  var_inf ( _p, _ppvar, _thread, _nt, *getarg(1) , *getarg(2) , *getarg(3) );
 hoc_retpushx(_r);
}
 
double var_tau ( _threadargsprotocomma_ double _lv , double _lvhalf , double _lvsteep , double _ltskew , double _ltscale , double _ltoffset ) {
   double _lvar_tau;
 _lvar_tau = _ltoffset + ( _ltscale / ( exp ( - _ltskew * ( _lv - _lvhalf ) / _lvsteep ) * ( 1.0 + exp ( ( _lv - _lvhalf ) / _lvsteep ) ) ) ) ;
   
return _lvar_tau;
 }
 
static void _hoc_var_tau(void) {
  double _r;
   double* _p; Datum* _ppvar; Datum* _thread; NrnThread* _nt;
   if (_extcall_prop) {_p = _extcall_prop->param; _ppvar = _extcall_prop->dparam;}else{ _p = (double*)0; _ppvar = (Datum*)0; }
  _thread = _extcall_thread;
  _nt = nrn_threads;
 _r =  var_tau ( _p, _ppvar, _thread, _nt, *getarg(1) , *getarg(2) , *getarg(3) , *getarg(4) , *getarg(5) , *getarg(6) );
 hoc_retpushx(_r);
}
 
static int _ode_count(int _type){ return 2;}
 
static void _ode_spec(NrnThread* _nt, _Memb_list* _ml, int _type) {
   double* _p; Datum* _ppvar; Datum* _thread;
   Node* _nd; double _v; int _iml, _cntml;
  _cntml = _ml->_nodecount;
  _thread = _ml->_thread;
  for (_iml = 0; _iml < _cntml; ++_iml) {
    _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
    _nd = _ml->_nodelist[_iml];
    v = NODEV(_nd);
  ena = _ion_ena;
     _ode_spec1 (_p, _ppvar, _thread, _nt);
  }}
 
static void _ode_map(int _ieq, double** _pv, double** _pvdot, double* _pp, Datum* _ppd, double* _atol, int _type) { 
	double* _p; Datum* _ppvar;
 	int _i; _p = _pp; _ppvar = _ppd;
	_cvode_ieq = _ieq;
	for (_i=0; _i < 2; ++_i) {
		_pv[_i] = _pp + _slist1[_i];  _pvdot[_i] = _pp + _dlist1[_i];
		_cvode_abstol(_atollist, _atol, _i);
	}
 }
 
static void _ode_matsol_instance1(_threadargsproto_) {
 _ode_matsol1 (_p, _ppvar, _thread, _nt);
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
  ena = _ion_ena;
 _ode_matsol_instance1(_threadargs_);
 }}
 extern void nrn_update_ion_pointer(Symbol*, Datum*, int, int);
 static void _update_ion_pointer(Datum* _ppvar) {
   nrn_update_ion_pointer(_na_sym, _ppvar, 0, 0);
   nrn_update_ion_pointer(_na_sym, _ppvar, 1, 3);
   nrn_update_ion_pointer(_na_sym, _ppvar, 2, 4);
 }

static void initmodel(double* _p, Datum* _ppvar, Datum* _thread, NrnThread* _nt) {
  int _i; double _save;{
  h = h0;
  m = m0;
 {
   rates ( _threadargscomma_ v ) ;
   m = minf ;
   h = hinf ;
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
  ena = _ion_ena;
 initmodel(_p, _ppvar, _thread, _nt);
 }
}

static double _nrn_current(double* _p, Datum* _ppvar, Datum* _thread, NrnThread* _nt, double _v){double _current=0.;v=_v;{ {
   ina = gbar * ( pow( m , exp_m ) ) * ( pow( h , exp_h ) ) * ( v - ena ) ;
   }
 _current += ina;

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
  ena = _ion_ena;
 _g = _nrn_current(_p, _ppvar, _thread, _nt, _v + .001);
 	{ double _dina;
  _dina = ina;
 _rhs = _nrn_current(_p, _ppvar, _thread, _nt, _v);
  _ion_dinadv += (_dina - ina)/.001 ;
 	}
 _g = (_g - _rhs)/.001;
  _ion_ina += ina ;
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
  ena = _ion_ena;
 {   states(_p, _ppvar, _thread, _nt);
  } }}

}

static void terminal(){}

static void _initlists(){
 double _x; double* _p = &_x;
 int _i; static int _first = 1;
  if (!_first) return;
 _slist1[0] = m_columnindex;  _dlist1[0] = Dm_columnindex;
 _slist1[1] = h_columnindex;  _dlist1[1] = Dh_columnindex;
_first = 0;
}

#if defined(__cplusplus)
} /* extern "C" */
#endif

#if NMODL_TEXT
static const char* nmodl_filename = "naf.mod";
static const char* nmodl_file_text = 
  ": Copyright (c) California Institute of Technology, 2006 -- All Rights Reserved\n"
  ": Royalty free license granted for non-profit research and educational purposes.\n"
  "TITLE Fast NA\n"
  "\n"
  "NEURON {\n"
  "	SUFFIX naf\n"
  "	USEION na READ ena WRITE ina\n"
  "\n"
  "	RANGE gbar\n"
  "	RANGE minf, mtau, hinf, htau\n"
  "\n"
  "	GLOBAL vhalf_m, vsteep_m, exp_m \n"
  "	GLOBAL tskew_m, tscale_m, toffset_m \n"
  "	\n"
  "	GLOBAL vhalf_h, vsteep_h, exp_h\n"
  "	GLOBAL tskew_h, tscale_h, toffset_h \n"
  "}\n"
  "\n"
  ":::INCLUDE \"inact_na_currs.inc\"\n"
  ": Copyright (c) California Institute of Technology, 2006 -- All Rights Reserved\n"
  ": Royalty free license granted for non-profit research and educational purposes.\n"
  "ASSIGNED {\n"
  "	ena        (mV)       \n"
  "	celsius    (degC)\n"
  "	v          (mV)\n"
  "	ina        (mA/cm2)\n"
  "	minf\n"
  "	mtau\n"
  "	hinf\n"
  "	htau\n"
  "}\n"
  "\n"
  "BREAKPOINT {\n"
  "	SOLVE states METHOD cnexp\n"
  "	ina = gbar*(m^exp_m)*(h^exp_h)*(v - ena)\n"
  "}\n"
  "\n"
  "INITIAL {\n"
  "\n"
  "	rates(v)\n"
  "	m = minf\n"
  "	h = hinf\n"
  "}\n"
  ":::end INCLUDE inact_na_currs.inc\n"
  "\n"
  ":::INCLUDE \"inact_gate_states.inc\"\n"
  ": Copyright (c) California Institute of Technology, 2006 -- All Rights Reserved\n"
  ": Royalty free license granted for non-profit research and educational purposes.\n"
  "UNITS {\n"
  "	(mA) = (milliamp)\n"
  "	(mV) = (millivolt)\n"
  "}\n"
  "\n"
  ": Initialize everything to zero - they should all be set from the\n"
  ": hoc code by the \"define_param\" function that writes the value\n"
  ": used to a parameter file (no magic numbers, anywhere...)\n"
  "\n"
  "PARAMETER {\n"
  "	vhalf_m = 0 (mV)\n"
  "	vsteep_m = 0 (mV)\n"
  "	tskew_m = 0 \n"
  "	tscale_m = 0 (ms)\n"
  "	toffset_m = 0 (ms)\n"
  "	exp_m = 0\n"
  "\n"
  "	vhalf_h = 0 (mV)\n"
  "	vsteep_h = 0 (mV)\n"
  "	tskew_h = 0 \n"
  "	tscale_h = 0 (ms)\n"
  "	toffset_h = 0 (ms)\n"
  "	exp_h = 0\n"
  "\n"
  "	gbar = 0 (mho/cm2)\n"
  "	\n"
  "\n"
  "}\n"
  "\n"
  "STATE {	m h }\n"
  "\n"
  "DERIVATIVE states {\n"
  "	rates(v)\n"
  "	m' = (minf-m)/mtau\n"
  "	h' = (hinf-h)/htau\n"
  "}\n"
  "\n"
  "\n"
  "\n"
  "PROCEDURE rates(v) {\n"
  "\n"
  "	minf = var_inf(v, vhalf_m, vsteep_m)\n"
  "	hinf = var_inf(v, vhalf_h, vsteep_h)\n"
  "\n"
  "	mtau =  var_tau(v, vhalf_m, vsteep_m, tskew_m, tscale_m, toffset_m)\n"
  "	htau =  var_tau(v, vhalf_h, vsteep_h, tskew_h, tscale_h, toffset_h)\n"
  "\n"
  "}\n"
  ":::end INCLUDE inact_gate_states.inc\n"
  "\n"
  ":::INCLUDE \"var_funcs.inc\"\n"
  ": Copyright (c) California Institute of Technology, 2006 -- All Rights Reserved\n"
  ": Royalty free license granted for non-profit research and educational purposes.\n"
  "FUNCTION var_inf(v(mV), vhalf(mV), vsteep(mV)) { \n"
  "\n"
  "	var_inf = 1 / (1 + exp((v - vhalf)/(vsteep))) \n"
  "\n"
  "}\n"
  "\n"
  "\n"
  "FUNCTION var_tau(v (mV), vhalf (mV), vsteep (mV), tskew, tscale(ms), toffset(ms)) {\n"
  "\n"
  "	var_tau = toffset + (tscale  / ( exp(-tskew*(v-vhalf)/vsteep) * (1+exp((v-vhalf)/vsteep)))  )\n"
  "\n"
  "\n"
  "}	\n"
  "\n"
  "\n"
  ":::end INCLUDE var_funcs.inc\n"
  ;
#endif
