#include <stdio.h>
#include <iostream>
#include <string>
using namespace std;

extern "C" void sv_write(int, int  );
extern "C" void sv_read (int, int *);

extern "C" void C_Program(void)
{
  int * RDATA;
  cout << "####################################################" << endl;
  cout << "  C++ function C_Program() was called from SV !!!!!!" << endl;
  cout << "####################################################" << endl;
  sv_write( 20, 5);
  sv_write(100,15);
  sv_write(200, 3);
  sv_write(222,11);
  sv_write(  2,33);
//sv_read (20, RDATA);
//cout << "  RDATA : " << RDATA << endl;
  return;
}

