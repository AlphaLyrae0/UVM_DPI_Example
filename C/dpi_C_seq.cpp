#include <stdio.h>
#include <iostream>
#include <string>
#include <stdlib.h>
using namespace std;

extern "C" void bus_drive(int, int); 

extern "C" void dpi_C_seq(void)
{
  int A, B;
  cout << "####################################################" << endl;
  cout << "  C++ function dpi_C_seq() was called from SV !!!!" << endl;
  cout << "####################################################" << endl;
  A = 120; B = 12;
  for(int i=0; i<5; i++, A += 110, B +=2 )
  {
    bus_drive(A, B);
  }

  cout << "====================================================" << endl;
  system("echo 'Even system command can also be called!!!!'");
  system("pwd");
  system("ls -l");
  system("cal");
  system("date");
//system("gwenview ../sand_box/DSC/DSC_out.ppm &");
  cout << "====================================================" << endl;
  return;
}

