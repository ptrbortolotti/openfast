program aerodyn_utest
use, intrinsic :: iso_fortran_env, only: error_unit
use testdrive, only: run_testsuite, new_testsuite, testsuite_type

use test_AD_FVW, only: test_AD_FVW_suite
use NWTC_Num

implicit none
integer :: stat, is, total_tests
type(testsuite_type), allocatable :: testsuites(:)
character(len=*), parameter :: fmt = '("#", *(1x, a))'

stat = 0

call SetConstants()

testsuites = [ &
             new_testsuite("FVW", test_AD_FVW_suite) &
             ]

total_tests = 0
do is = 1, size(testsuites)
   write (error_unit, fmt) "Testing:", testsuites(is)%name
   call run_testsuite(testsuites(is)%collect, error_unit, stat)
end do

if (stat > 0) then
   write (error_unit, '(i0, 1x, a)') stat, "test(s) failed!"
   error stop
end if

write (error_unit, fmt) "All tests PASSED"

end program
