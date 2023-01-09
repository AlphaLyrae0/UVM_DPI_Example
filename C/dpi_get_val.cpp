#include <stdio.h>
#include <iostream>
#include <string>
using namespace std;

extern "C" void dpi_get_val(int * A_ptr, int * B_ptr)
{
  cout << "####################################################" << endl;
  cout << "  C++ function dpi_set_val() was called from SV !!!!" << endl;
  cout << "####################################################" << endl;
  *A_ptr += 120;
  *B_ptr += 12;
  return;
}

